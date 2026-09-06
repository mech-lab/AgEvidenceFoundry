# frozen_string_literal: true

require "date"

module Factory
  module Operations
    class ResearchStaleness
      DEFAULT_EXPIRY_DAYS = 90

      attr_reader :pack, :today

      def initialize(pack, today: Date.today)
        @pack = pack
        @today = today
      end

      def rows
        claims.map do |claim|
          checked_at = parse_date(claim["checked_at"] || claim["last_checked"] || claim["accessed_at"])
          expiry_days = (claim["expires_after_days"] || DEFAULT_EXPIRY_DAYS).to_i
          stale = checked_at ? today > checked_at + expiry_days : true
          claim.merge(
            "checked_at_date" => checked_at,
            "expires_after_days" => expiry_days,
            "stale" => stale
          )
        end
      end

      def render
        stale = rows.select { |row| row["stale"] }
        valid = rows.reject { |row| row["stale"] }
        "#{valid.length} claims valid\n#{stale.length} claims stale"
      end

      private

      def claims
        pack.proof_points + pack.sources
      end

      def parse_date(value)
        return nil if value.nil?

        Date.iso8601(value.to_s)
      rescue ArgumentError
        nil
      end
    end
  end
end
