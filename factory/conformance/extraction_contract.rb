# frozen_string_literal: true

require "pathname"

module Factory
  class ExtractionContract
    REQUIRED_PROVENANCE_FILES = %w[
      AGEVIDENCE_BASE
      FOUNDRY_ORIGIN
    ].freeze

    attr_reader :path

    def initialize(path)
      @path = Pathname(path)
    end

    def validate
      REQUIRED_PROVENANCE_FILES.reject { |file| path.join(file).file? }
                                .map { |file| "extraction missing #{file}" }
    end
  end
end
