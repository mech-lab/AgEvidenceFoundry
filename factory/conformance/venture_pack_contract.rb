# frozen_string_literal: true

require_relative "../loaders/program_profile_loader"
require_relative "../loaders/terminology_loader"
require_relative "../loaders/venture_pack"
require_relative "schema_validator"

module Factory
  class VenturePackContract
    REQUIRED_KEYS = %w[
      id
      name
      agevidence
      market
      reliance
      terminology
      features
      program_profiles
      integrations
      acceptance_gates
      reliance_gate
    ].freeze

    REQUIRED_FEATURES = %w[
      source_records
      observations
      spatial_observations
      intervention_events
      operational_events
      model_runs
      reviewer_workflow
      artifact_export
      verification
      reliance
    ].freeze

    REQUIRED_ACCEPTANCE_GATES = %w[
      evidence_ingested
      evaluation_completed
      human_review_completed
      artifact_issued
      artifact_verified
      external_reliance_recorded
    ].freeze

    REQUIRED_RELIANCE_GATE_KEYS = %w[
      relying_party
      decision
      required
      success_event
    ].freeze

    REQUIRED_RELIANCE_CONTROLS = %w[
      source_provenance
      accepted_evidence
      requirements_evaluated
      human_review
      bounded_determination
      immutable_artifact
      independent_verification
    ].freeze

    class ValidationError < StandardError; end

    attr_reader :pack

    def initialize(pack)
      @pack = pack
    end

    def validate
      errors = []
      errors.concat(validate_schemas)
      errors.concat(validate_required_keys)
      errors.concat(validate_identity)
      errors.concat(validate_features)
      errors.concat(validate_terminology)
      errors.concat(validate_program_profiles)
      errors.concat(validate_vertical_files)
      errors.concat(validate_acceptance_gates)
      errors.concat(validate_reliance_gate)
      errors
    end

    def validate!
      errors = validate
      raise ValidationError, errors.join("\n") if errors.any?

      true
    end

    private

    def validate_schemas
      validator = SchemaValidator.new(root: VenturePack.repo_root)
      errors = validator.validate(
        pack.data,
        schema_path: "factory/schemas/venture-pack.schema.json",
        label: "#{pack.id}: product/venture.yml"
      )
      pack.integration_files.each do |integration|
        label = "#{pack.id}: product/#{integration.fetch('source_path', 'integrations')}"
        data = integration.reject { |key, _value| key == "source_path" }
        errors.concat(validator.validate(data, schema_path: "factory/schemas/integration.schema.json", label: label))
      end
      errors
    end

    def validate_required_keys
      missing = REQUIRED_KEYS.reject { |key| present?(pack.data[key]) }
      missing.map { |key| "#{pack.id}: missing #{key}" }
    end

    def validate_identity
      errors = []
      errors << "#{pack.id}: id must match company directory name #{pack.company_id}" unless pack.id == pack.company_id
      errors << "#{pack.id}: agevidence.protocol_version is required" unless present?(pack.protocol_version)
      errors << "#{pack.id}: agevidence.minimum_foundry_version is required" unless present?(pack.minimum_foundry_version)
      errors
    end

    def validate_features
      errors = []
      missing = REQUIRED_FEATURES.reject { |feature| pack.features.key?(feature) }
      errors << "#{pack.id}: missing feature declarations: #{missing.join(', ')}" if missing.any?

      non_boolean = pack.features.select { |_key, value| ![true, false].include?(value) }.keys
      errors << "#{pack.id}: feature declarations must be booleans: #{non_boolean.join(', ')}" if non_boolean.any?
      errors
    end

    def validate_terminology
      missing = TerminologyLoader.new(pack).missing_terms
      return [] if missing.empty?

      ["#{pack.id}: missing terminology: #{missing.join(', ')}"]
    end

    def validate_program_profiles
      loader = ProgramProfileLoader.new(pack)
      missing_files = loader.declared_ids - loader.file_ids
      counts = Hash.new(0)
      loader.file_ids.each { |profile_id| counts[profile_id] += 1 }
      duplicate_files = counts.select { |_id, count| count > 1 }.keys
      errors = []
      errors << "#{pack.id}: missing program profile files for: #{missing_files.join(', ')}" if missing_files.any?
      errors << "#{pack.id}: duplicate program profile files: #{duplicate_files.join(', ')}" if duplicate_files.any?
      errors
    end

    def validate_vertical_files
      errors = []
      errors << "#{pack.id}: at least one requirement is required" if pack.requirements.empty?
      errors << "#{pack.id}: at least one evidence type is required" if pack.evidence_types.empty?
      errors << "#{pack.id}: at least one artifact template is required" if pack.artifact_templates.empty?
      errors << "#{pack.id}: at least one seed scenario is required" if pack.seed_files.empty?
      errors
    end

    def validate_acceptance_gates
      missing = REQUIRED_ACCEPTANCE_GATES - pack.acceptance_gates
      return [] if missing.empty?

      ["#{pack.id}: missing acceptance gates: #{missing.join(', ')}"]
    end

    def validate_reliance_gate
      gate = pack.reliance_contract
      errors = []
      missing = REQUIRED_RELIANCE_GATE_KEYS.reject { |key| present?(gate[key]) }
      errors << "#{pack.id}: reliance_gate missing: #{missing.join(', ')}" if missing.any?

      controls = Array(gate["required"])
      missing_controls = REQUIRED_RELIANCE_CONTROLS - controls
      errors << "#{pack.id}: reliance_gate.required missing: #{missing_controls.join(', ')}" if missing_controls.any?

      success_event = gate.fetch("success_event", {})
      errors << "#{pack.id}: reliance_gate.success_event.type is required" unless present?(success_event["type"])
      errors
    end

    def present?(value)
      case value
      when nil
        false
      when String, Array, Hash
        !value.empty?
      else
        true
      end
    end
  end
end
