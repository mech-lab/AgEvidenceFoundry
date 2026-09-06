# frozen_string_literal: true

module Factory
  module Operations
    class PitchRenderer
      attr_reader :pack, :audience

      def initialize(pack, audience:)
        @pack = pack
        @audience = audience.to_s
      end

      def render
        data = pack.pitch(audience)
        raise KeyError, "unknown pitch audience #{audience} for #{pack.id}" if data.empty?

        lines = []
        lines << "# #{pack.name}"
        lines << ""
        lines << pack.brand.dig("category", "descriptor").to_s
        lines << ""
        lines << pack.brand.dig("gtm_proposition", "text").to_s
        lines << ""
        Array(data["sections"]).each do |section|
          lines << "## #{section['title']}"
          lines << ""
          lines << section["body"].to_s
          lines << ""
        end
        lines.join("\n").rstrip
      end
    end
  end
end
