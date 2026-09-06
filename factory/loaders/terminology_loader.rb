# frozen_string_literal: true

require_relative "venture_pack"

module Factory
  class TerminologyLoader
    REQUIRED_TERMS = %w[
      project
      gap
      determination
      artifact
      program_profile
      reliance_event
    ].freeze

    attr_reader :pack

    def initialize(pack)
      @pack = pack
    end

    def missing_terms
      REQUIRED_TERMS.reject { |term| pack.terminology.key?(term) }
    end

    def complete?
      missing_terms.empty?
    end
  end
end
