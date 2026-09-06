# frozen_string_literal: true

require "date"
require "find"
require "pathname"

module Factory
  autoload :VenturePackLoader, File.expand_path("venture_pack_loader", __dir__)

  def self.deep_stringify(value)
    case value
    when Hash
      value.each_with_object({}) { |(key, item), result| result[key.to_s] = deep_stringify(item) }
    when Array
      value.map { |item| deep_stringify(item) }
    else
      value
    end
  end

  class VenturePack
    DEFAULT_ID = "methaneproof"

    attr_reader :data, :path

    def self.repo_root
      Pathname.new(__dir__).join("..", "..").expand_path
    end

    def self.current(env: ENV, root: repo_root)
      id = env.fetch("VENTURE_PACK", "").to_s.strip
      id = DEFAULT_ID if id.empty?
      VenturePackLoader.new(root: root).load(id)
    end

    def initialize(path:, data:)
      @path = Pathname(path)
      @data = Factory.deep_stringify(data)
    end

    def id
      data.fetch("id")
    end

    def company_path
      path.basename.to_s == "product" ? path.dirname : path
    end

    def company_id
      company_path.basename.to_s
    end

    def name
      data.fetch("name")
    end

    def agevidence
      data.fetch("agevidence", {})
    end

    def protocol_version
      agevidence["protocol_version"]
    end

    def minimum_foundry_version
      agevidence["minimum_foundry_version"]
    end

    def market
      data.fetch("market", {})
    end

    def features
      data.fetch("features", {})
    end

    def enabled?(capability)
      features.fetch(capability.to_s, false) == true
    end

    def terminology
      data.fetch("terminology", {})
    end

    def term(canonical, form: :singular)
      value = terminology[canonical.to_s]
      return canonical.to_s if value.nil?

      case value
      when Hash
        value[form.to_s] || value["singular"] || canonical.to_s
      else
        value.to_s
      end
    end

    def program_profiles
      Array(data["program_profiles"])
    end

    def integrations
      Array(data["integrations"])
    end

    def integration_files
      yaml_files("integrations")
    end

    def acceptance_gates
      Array(data["acceptance_gates"])
    end

    def reliance
      data.fetch("reliance", {})
    end

    def reliance_contract
      data.fetch("reliance_gate", {})
    end

    def requirements
      yaml_files("requirements")
    end

    def evidence_types
      yaml_files("evidence_types")
    end

    def artifact_templates
      yaml_files("artifact_templates")
    end

    def program_profile_files
      yaml_files("program_profiles")
    end

    def seed_files
      yaml_files("seeds")
    end

    def summary
      {
        "id" => id,
        "name" => name,
        "protocol_version" => protocol_version,
        "minimum_foundry_version" => minimum_foundry_version,
        "category" => market["category"],
        "program_profiles" => program_profiles,
        "integrations" => integrations,
        "reliance_gate" => reliance_contract
      }
    end

    private

    def yaml_files(relative_dir)
      dir = path.join(relative_dir)
      return [] unless dir.directory?

      files = []
      Find.find(dir.to_s) do |file|
        path = Pathname(file)
        files << path if path.file? && %w[.yml .yaml].include?(path.extname)
      end

      files.sort.map { |file| load_yaml_with_source(file) }
    end

    def load_yaml_with_source(file)
      require "yaml"

      value = YAML.safe_load(file.read, permitted_classes: [Date, Time], aliases: false) || {}
      Factory.deep_stringify(value).merge("source_path" => file.relative_path_from(path).to_s)
    end
  end
end
