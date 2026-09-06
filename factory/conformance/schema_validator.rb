# frozen_string_literal: true

require "date"
require "json"
require "pathname"

module Factory
  class SchemaValidator
    SUPPORTED_KEYS = %w[
      $id
      $ref
      $schema
      additionalProperties
      description
      enum
      format
      items
      maximum
      maxItems
      maxLength
      minimum
      minItems
      minLength
      oneOf
      pattern
      properties
      required
      title
      type
    ].freeze

    attr_reader :root

    def initialize(root: VenturePack.repo_root)
      @root = Pathname(root)
      @schema_cache = {}
    end

    def validate(data, schema_path:, label:)
      schema_file = root.join(schema_path)
      validate_node(data, load_schema(schema_file), path: "$", schema_file: schema_file).map do |error|
        "#{label}: #{error}"
      end
    end

    private

    def load_schema(path)
      @schema_cache[path.to_s] ||= JSON.parse(path.read)
    end

    def validate_node(value, schema, path:, schema_file:)
      return [] unless schema.is_a?(Hash)

      ref = schema["$ref"]
      return validate_ref(value, ref, path: path, schema_file: schema_file) if ref

      unsupported = schema.keys - SUPPORTED_KEYS
      return unsupported.map { |key| "#{path} uses unsupported schema keyword #{key}" } if unsupported.any?

      one_of = schema["oneOf"]
      return validate_one_of(value, one_of, path: path, schema_file: schema_file) if one_of

      errors = []
      errors.concat(validate_type(value, schema, path))
      errors.concat(validate_enum(value, schema, path))
      errors.concat(validate_string(value, schema, path))
      errors.concat(validate_number(value, schema, path))
      errors.concat(validate_array(value, schema, path, schema_file))
      errors.concat(validate_object(value, schema, path, schema_file))
      errors
    end

    def validate_ref(value, ref, path:, schema_file:)
      raise ArgumentError, "only local schema refs are supported: #{ref}" if ref.include?("#") || ref.match?(%r{\A[a-z]+:}i)

      validate_node(value, load_schema(schema_file.dirname.join(ref)), path: path, schema_file: schema_file.dirname.join(ref))
    end

    def validate_one_of(value, one_of, path:, schema_file:)
      return ["#{path} oneOf must be an array"] unless one_of.is_a?(Array)

      matches = one_of.count { |candidate| validate_node(value, candidate, path: path, schema_file: schema_file).empty? }
      return [] if matches == 1

      ["#{path} must match exactly one schema option, matched #{matches}"]
    end

    def validate_type(value, schema, path)
      expected = Array(schema["type"]).compact
      return [] if expected.empty?
      return [] if expected.any? { |type| type_matches?(value, type, schema) }

      ["#{path} must be #{expected.join(' or ')}, got #{type_name(value)}"]
    end

    def validate_enum(value, schema, path)
      values = schema["enum"]
      return [] unless values
      return [] if values.include?(value)

      ["#{path} must be one of #{values.join(', ')}"]
    end

    def validate_string(value, schema, path)
      return [] unless string_like?(value, schema)

      errors = []
      string = value.to_s
      errors << "#{path} must be at least #{schema['minLength']} characters" if schema["minLength"] && string.length < schema["minLength"]
      errors << "#{path} must be at most #{schema['maxLength']} characters" if schema["maxLength"] && string.length > schema["maxLength"]
      errors << "#{path} must match #{schema['pattern']}" if schema["pattern"] && !Regexp.new(schema["pattern"]).match?(string)
      errors << "#{path} must be an ISO date" if schema["format"] == "date" && !date_like?(value)
      errors
    end

    def validate_number(value, schema, path)
      return [] unless value.is_a?(Numeric)

      errors = []
      errors << "#{path} must be >= #{schema['minimum']}" if schema["minimum"] && value < schema["minimum"]
      errors << "#{path} must be <= #{schema['maximum']}" if schema["maximum"] && value > schema["maximum"]
      errors
    end

    def validate_array(value, schema, path, schema_file)
      return [] unless value.is_a?(Array)

      errors = []
      errors << "#{path} must contain at least #{schema['minItems']} items" if schema["minItems"] && value.length < schema["minItems"]
      errors << "#{path} must contain at most #{schema['maxItems']} items" if schema["maxItems"] && value.length > schema["maxItems"]
      if schema["items"]
        value.each_with_index do |item, index|
          errors.concat(validate_node(item, schema["items"], path: "#{path}[#{index}]", schema_file: schema_file))
        end
      end
      errors
    end

    def validate_object(value, schema, path, schema_file)
      return [] unless value.is_a?(Hash)

      errors = []
      Array(schema["required"]).each do |key|
        errors << "#{path} missing required property #{key}" unless value.key?(key)
      end

      properties = schema["properties"] || {}
      value.each do |key, item|
        if properties.key?(key)
          errors.concat(validate_node(item, properties[key], path: "#{path}.#{key}", schema_file: schema_file))
        else
          errors.concat(validate_additional_property(key, item, schema, path, schema_file))
        end
      end
      errors
    end

    def validate_additional_property(key, value, schema, path, schema_file)
      additional = schema.fetch("additionalProperties", true)
      return [] if additional == true
      return ["#{path}.#{key} is not allowed"] if additional == false

      validate_node(value, additional, path: "#{path}.#{key}", schema_file: schema_file)
    end

    def type_matches?(value, type, schema)
      case type
      when "object"
        value.is_a?(Hash)
      when "array"
        value.is_a?(Array)
      when "string"
        value.is_a?(String) || (schema["format"] == "date" && date_like?(value))
      when "integer"
        value.is_a?(Integer)
      when "number"
        value.is_a?(Numeric)
      when "boolean"
        value == true || value == false
      when "null"
        value.nil?
      else
        false
      end
    end

    def string_like?(value, schema)
      value.is_a?(String) || (schema["format"] == "date" && date_like?(value))
    end

    def date_like?(value)
      case value
      when Date, Time
        true
      when String
        return false unless value.match?(/\A\d{4}-\d{2}-\d{2}\z/)

        Date.iso8601(value)
        true
      else
        false
      end
    rescue Date::Error
      false
    end

    def type_name(value)
      case value
      when Hash
        "object"
      when Array
        "array"
      when String
        "string"
      when Integer
        "integer"
      when Numeric
        "number"
      when TrueClass, FalseClass
        "boolean"
      when NilClass
        "null"
      else
        value.class.name
      end
    end
  end
end
