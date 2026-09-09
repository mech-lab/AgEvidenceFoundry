# frozen_string_literal: true

require "date"
require "pathname"
require "yaml"
require_relative "venture_pack"

module Factory
  class CompanyPack
    DEFAULT_ID = VenturePack::DEFAULT_ID

    attr_reader :path, :data, :product_pack

    def self.repo_root
      VenturePack.repo_root
    end

    def self.current(env: ENV, root: repo_root)
      id = env.fetch("VENTURE_PACK", "").to_s.strip
      id = DEFAULT_ID if id.empty?
      CompanyPackLoader.new(root: root).load(id)
    end

    def initialize(path:, data:, product_pack:)
      @path = Pathname(path)
      @data = Factory.deep_stringify(data)
      @product_pack = product_pack
    end

    def id
      data.fetch("id")
    end

    def name
      data.dig("company", "working_name") || product_pack.name
    end

    def company
      data.fetch("company", {})
    end

    def formation_architecture
      data.fetch("formation_architecture", {})
    end

    def category
      data.fetch("category", {})
    end

    def buyer
      data.fetch("buyer", {})
    end

    def problem
      data.fetch("problem", {})
    end

    def reliance
      data.fetch("reliance", {})
    end

    def land_motion
      data.fetch("land_motion", {})
    end

    def gtm
      data.fetch("gtm", {})
    end

    def brand
      read_yaml("brand/brand.yml")
    end

    def naming
      read_yaml("brand/naming.yml")
    end

    def claim_discipline
      read_yaml("brand/claim_discipline.yml")
    end

    def visual
      read_yaml("brand/visual.yml")
    end

    def pitch(name)
      read_yaml("pitch/#{name}.yml")
    end

    def proof_points
      read_yaml("pitch/proof_points.yml").fetch("proof_points", []) +
        read_yaml("research/hypotheses.yml").fetch("claims", [])
    end

    def offers
      read_yaml("gtm/offers.yml").fetch("offers", [])
    end

    def scoring
      read_yaml("gtm/scoring.yml")
    end

    def pricing_policy
      read_yaml("gtm/pricing.yml").fetch("pricing", {})
    end

    def validation_file(relative_path)
      read_yaml("gtm/validation/#{relative_path}.yml")
    end

    def validation_hypothesis
      validation_file("hypothesis")
    end

    def validation_actor_map
      validation_file("actor_map")
    end

    def problem_interview_plan
      validation_file("problem/interview_plan")
    end

    def problem_signals
      validation_file("problem/signals")
    end

    def pricing_hypothesis
      validation_file("pricing/hypothesis")
    end

    def pricing_interview_guide
      validation_file("pricing/interview_guide")
    end

    def pricing_tests
      validation_file("pricing/tests")
    end

    def pricing_observations
      validation_file("pricing/observations")
    end

    def pricing_synthesis
      validation_file("pricing/synthesis")
    end

    def validation_synthesis
      validation_file("synthesis")
    end

    def validation_gate
      validation_file("gate")
    end

    def artifact_tests
      validation_file("artifact_tests")
    end

    def validation_interviews
      dir = path.join("gtm/validation/interviews")
      return [] unless dir.directory?

      dir.children(false).select { |file| %w[.yml .yaml].include?(file.extname) }.sort.map do |file|
        read_yaml("gtm/validation/interviews/#{file}").merge("source_path" => "gtm/validation/interviews/#{file}")
      end
    end

    def accounts
      read_yaml("accounts/accounts.yml").fetch("accounts", [])
    end

    def contacts
      read_yaml("accounts/contacts.yml").fetch("contacts", [])
    end

    def sources
      read_yaml("research/sources.yml").fetch("sources", [])
    end

    def formation_status
      read_yaml("formation/status.yml")
    end

    def read_yaml(relative_path)
      file = path.join(relative_path)
      return {} unless file.file?

      Factory.deep_stringify(YAML.safe_load(file.read, permitted_classes: [Date, Time], aliases: false) || {})
    end

    def summary
      product_pack.summary.merge(
        "name" => name,
        "product_name" => product_pack.name,
        "company" => company,
        "formation_architecture" => formation_architecture,
        "category" => category,
        "buyer" => buyer,
        "brand" => {
          "name" => brand.dig("name", "primary"),
          "category_descriptor" => brand.dig("category", "descriptor"),
          "mode" => data.dig("brand", "mode")
        },
        "gtm" => gtm
      )
    end
  end
end
