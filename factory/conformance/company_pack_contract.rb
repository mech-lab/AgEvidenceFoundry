# frozen_string_literal: true

require "date"
require_relative "venture_pack_contract"
require_relative "schema_validator"
require_relative "../loaders/company_pack"

module Factory
  class CompanyPackContract
    REQUIRED_COMPANY_KEYS = %w[
      id
      company
      category
      buyer
      problem
      reliance
      land_motion
      gtm
      brand
      agevidence
    ].freeze

    REQUIRED_BRAND_KEYS = %w[name category primary_line gtm_proposition role audience].freeze
    REQUIRED_NAMING_TESTS = %w[buyer_recognition role_discipline land_motion_fit expansion_permission investor_signal].freeze
    REQUIRED_CLAIM_KEYS = %w[allowed requires_qualification prohibited regulated_roles].freeze
    REQUIRED_GTM_FILES = %w[market icp pricing offers channels objections discovery scoring].freeze
    REQUIRED_PITCH_FILES = %w[thesis customer investor founder architecture proof_points].freeze
    REQUIRED_FORMATION_GATES = %w[
      reliance_hypothesis
      founder_identified
      naming_screen
      trademark_clearance
      buyer_language_test
      tier1_accounts
      design_partner
      paid_pilot
      artifact_issued
      external_reliance
      spinout
    ].freeze

    VALID_CONTACT_ROLES = %w[EB CH TU EX IN BL PA EV].freeze
    VALID_CONFIDENCE = %w[A B C D].freeze
    VALID_GATE_STATUSES = %w[passed pending active locked failed].freeze

    attr_reader :pack

    def initialize(pack)
      @pack = pack
    end

    def validate
      errors = []
      errors.concat(validate_schemas)
      errors.concat(VenturePackContract.new(pack.product_pack).validate)
      errors.concat(validate_company_manifest)
      errors.concat(validate_brand)
      errors.concat(validate_gtm)
      errors.concat(validate_accounts)
      errors.concat(validate_contacts)
      errors.concat(validate_pitch)
      errors.concat(validate_research)
      errors.concat(validate_formation)
      errors
    end

    def validate!
      errors = validate
      raise VenturePackContract::ValidationError, errors.join("\n") if errors.any?

      true
    end

    private

    def validate_schemas
      validator = SchemaValidator.new(root: CompanyPack.repo_root)
      errors = []

      errors.concat(validator.validate(pack.data, schema_path: "commercial/schemas/company-pack.schema.json", label: "#{pack.id}: company.yml"))
      errors.concat(validator.validate(pack.brand, schema_path: "commercial/schemas/brand.schema.json", label: "#{pack.id}: brand/brand.yml"))
      errors.concat(validator.validate(pack.naming, schema_path: "commercial/schemas/naming.schema.json", label: "#{pack.id}: brand/naming.yml"))
      errors.concat(validator.validate(pack.claim_discipline, schema_path: "commercial/schemas/claim-discipline.schema.json", label: "#{pack.id}: brand/claim_discipline.yml"))
      errors.concat(validator.validate(pack.formation_status, schema_path: "commercial/schemas/formation-status.schema.json", label: "#{pack.id}: formation/status.yml"))

      pack.accounts.each_with_index do |account, index|
        account_id = account["id"] || index
        errors.concat(validator.validate(account, schema_path: "commercial/schemas/account.schema.json", label: "#{pack.id}: accounts/accounts.yml account #{account_id}"))
      end

      pack.contacts.each_with_index do |contact, index|
        contact_id = contact["id"] || index
        errors.concat(validator.validate(contact, schema_path: "commercial/schemas/contact.schema.json", label: "#{pack.id}: accounts/contacts.yml contact #{contact_id}"))
      end

      pack.offers.each_with_index do |offer, index|
        offer_id = offer["id"] || index
        errors.concat(validator.validate(offer, schema_path: "commercial/schemas/offer.schema.json", label: "#{pack.id}: gtm/offers.yml offer #{offer_id}"))
      end

      pack.sources.each_with_index do |source, index|
        source_id = source["id"] || index
        errors.concat(validator.validate(source, schema_path: "commercial/schemas/source.schema.json", label: "#{pack.id}: research/sources.yml source #{source_id}"))
      end

      pack.path.join("formation", "experiments").children(false).select { |file| file.extname == ".yml" }.sort.each do |file|
        errors.concat(
          validator.validate(
            pack.read_yaml("formation/experiments/#{file}"),
            schema_path: "commercial/schemas/experiment.schema.json",
            label: "#{pack.id}: formation/experiments/#{file}"
          )
        )
      end

      %w[customer investor founder architecture].each do |audience|
        errors.concat(validator.validate(pack.pitch(audience), schema_path: "commercial/schemas/pitch.schema.json", label: "#{pack.id}: pitch/#{audience}.yml"))
      end

      pack.pitch("proof_points").fetch("proof_points", []).each_with_index do |proof_point, index|
        proof_id = proof_point["id"] || index
        errors.concat(validator.validate(proof_point, schema_path: "commercial/schemas/proof-point.schema.json", label: "#{pack.id}: pitch/proof_points.yml proof point #{proof_id}"))
      end

      errors
    end

    def validate_company_manifest
      errors = []
      missing = REQUIRED_COMPANY_KEYS.reject { |key| present?(pack.data[key]) }
      errors << "#{pack.id}: company.yml missing: #{missing.join(', ')}" if missing.any?
      errors << "#{pack.id}: company.yml id must match directory" unless pack.id == pack.path.basename.to_s
      errors << "#{pack.id}: company working_name must match brand primary name" if present?(pack.brand.dig("name", "primary")) && pack.name != pack.brand.dig("name", "primary")
      errors
    end

    def validate_brand
      errors = []
      brand = pack.brand
      missing = REQUIRED_BRAND_KEYS.reject { |key| present?(brand[key]) }
      errors << "#{pack.id}: brand/brand.yml missing: #{missing.join(', ')}" if missing.any?

      naming_tests = pack.naming.fetch("tests", {})
      missing_tests = REQUIRED_NAMING_TESTS.reject { |key| present?(naming_tests[key]) }
      errors << "#{pack.id}: brand/naming.yml missing tests: #{missing_tests.join(', ')}" if missing_tests.any?

      naming_tests.each do |test_id, test|
        score = test["score"]
        unless score.is_a?(Numeric) && score >= 0 && score <= 5
          errors << "#{pack.id}: naming test #{test_id} score must be 0..5"
        end

        errors << "#{pack.id}: naming test #{test_id} uses legacy evidence key; use evidence_refs" if present?(test["evidence"])
      end

      evidence_refs = pack.sources.map { |source| source["id"] } + pack.pitch("proof_points").fetch("proof_points", []).map { |proof_point| proof_point["id"] }
      naming_tests.each do |test_id, test|
        Array(test["evidence_refs"]).each do |ref|
          errors << "#{pack.id}: naming test #{test_id} references unknown evidence #{ref}" unless evidence_refs.include?(ref)
        end
      end

      claim_missing = REQUIRED_CLAIM_KEYS.reject { |key| present?(pack.claim_discipline[key]) }
      errors << "#{pack.id}: brand/claim_discipline.yml missing: #{claim_missing.join(', ')}" if claim_missing.any?
      errors << "#{pack.id}: brand/visual.yml missing family" unless present?(pack.visual["family"])
      errors
    end

    def validate_gtm
      errors = []
      REQUIRED_GTM_FILES.each do |name|
        errors << "#{pack.id}: missing gtm/#{name}.yml" unless pack.path.join("gtm", "#{name}.yml").file?
      end

      dimensions = pack.scoring.fetch("dimensions", {})
      total_weight = dimensions.values.map { |dimension| dimension["weight"].to_i }.reduce(0, :+)
      errors << "#{pack.id}: gtm/scoring.yml weights must total 100" unless total_weight == 100

      pack.offers.each do |offer|
        %w[id objective scope duration outputs success_gate pricing].each do |key|
          errors << "#{pack.id}: offer missing #{key}" unless present?(offer[key])
        end
      end
      errors
    end

    def validate_accounts
      errors = []
      account_ids = []
      tier1_count = 0
      dimensions = pack.scoring.fetch("dimensions", {})
      dimension_keys = dimensions.keys
      source_ids = pack.sources.map { |source| source["id"] }

      pack.accounts.each do |account|
        account_id = account["id"]
        account_ids << account_id
        tier = account.dig("priority", "tier").to_i
        tier1_count += 1 if tier == 1

        %w[organization venture_role priority trigger buyer_map evidence_stack evidence_problem first_offer expansion next_action confidence source_ledger].each do |key|
          errors << "#{pack.id}: account #{account_id} missing #{key}" unless present?(account[key])
        end

        if tier == 1
          %w[event_date observed_at type source].each do |key|
            errors << "#{pack.id}: Tier-1 account #{account_id} trigger missing #{key}" unless present?(account.dig("trigger", key))
          end
        end

        errors << "#{pack.id}: account #{account_id} uses legacy trigger.date; use trigger.event_date and trigger.observed_at" if present?(account.dig("trigger", "date"))

        errors << "#{pack.id}: account #{account_id} trigger source is unknown" if present?(account.dig("trigger", "source")) && !source_ids.include?(account.dig("trigger", "source"))

        components = account.fetch("score_components", {})
        missing_components = dimension_keys.reject { |dimension| present?(components.dig(dimension, "score")) && present?(components.dig(dimension, "evidence")) }
        errors << "#{pack.id}: account #{account_id} missing score components: #{missing_components.join(', ')}" if missing_components.any?

        computed_score = 0
        components.each do |dimension, component|
          score = component["score"].to_i
          weight = dimensions.dig(dimension, "weight").to_i
          computed_score += score
          errors << "#{pack.id}: account #{account_id} score component #{dimension} exceeds weight #{weight}" if weight.positive? && score > weight
          errors << "#{pack.id}: account #{account_id} score component #{dimension} has unknown evidence #{component['evidence']}" if present?(component["evidence"]) && !source_ids.include?(component["evidence"])
        end

        declared_score = account.dig("priority", "score").to_i
        errors << "#{pack.id}: account #{account_id} priority score #{declared_score} does not match computed #{computed_score}" if declared_score != computed_score
      end

      errors << "#{pack.id}: duplicate account ids" if account_ids.uniq.length != account_ids.length
      errors << "#{pack.id}: at least one Tier-1 account is required" if tier1_count.zero?
      errors
    end

    def validate_contacts
      errors = []
      pack.contacts.each do |contact|
        errors << "#{pack.id}: contact #{contact['id']} has unknown role #{contact['role']}" unless VALID_CONTACT_ROLES.include?(contact["role"])
        errors << "#{pack.id}: contact #{contact['id']} has unknown confidence #{contact['confidence']}" unless VALID_CONFIDENCE.include?(contact["confidence"])
      end
      errors
    end

    def validate_pitch
      errors = []
      REQUIRED_PITCH_FILES.each do |name|
        errors << "#{pack.id}: missing pitch/#{name}.yml" unless pack.path.join("pitch", "#{name}.yml").file?
      end
      errors << "#{pack.id}: pitch/proof_points.yml must define proof_points" unless present?(pack.pitch("proof_points")["proof_points"])
      errors
    end

    def validate_research
      errors = []
      errors << "#{pack.id}: research/sources.yml must define sources" unless present?(pack.sources)
      source_ids = pack.sources.map { |source| source["id"] }
      pack.sources.each do |source|
        %w[id type title accessed_at].each do |key|
          errors << "#{pack.id}: source #{source['id']} missing #{key}" unless present?(source[key])
        end
        if present?(source["path"]) && (source["path"].start_with?("/") || source["path"].start_with?("~"))
          errors << "#{pack.id}: source #{source['id']} path must be repo-relative, not machine-local"
        end
      end
      pack.proof_points.each do |proof_point|
        errors << "#{pack.id}: proof point #{proof_point['id']} references unknown source #{proof_point['source']}" if present?(proof_point["source"]) && !source_ids.include?(proof_point["source"])
        errors << "#{pack.id}: GTM inference #{proof_point['id']} must not be marked for external use" if proof_point["evidence_class"] == "gtm_inference" && proof_point["external_use"] != false
        errors << "#{pack.id}: GTM inference #{proof_point['id']} must not be marked for external use" if proof_point["classification"] == "gtm_inference" && proof_point["external_use"] != false
      end
      errors
    end

    def validate_formation
      errors = []
      status = pack.formation_status
      errors << "#{pack.id}: formation/status.yml stage is required" unless present?(status["stage"])
      gates = status.fetch("gates", {})
      missing_gates = REQUIRED_FORMATION_GATES.reject { |gate| present?(gates[gate]) }
      errors << "#{pack.id}: formation/status.yml missing gates: #{missing_gates.join(', ')}" if missing_gates.any?
      gates.each do |gate_name, gate|
        errors << "#{pack.id}: formation gate #{gate_name} has unknown status #{gate['status']}" unless VALID_GATE_STATUSES.include?(gate["status"])
      end
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
