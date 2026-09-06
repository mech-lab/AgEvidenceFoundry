# frozen_string_literal: true

module Factory
  module Operations
    class GtmValidator
      attr_reader :pack

      def initialize(pack)
        @pack = pack
      end

      def errors
        dimensions = pack.scoring.fetch("dimensions", {}).keys
        pack.accounts.flat_map do |account|
          validate_account(account, dimensions)
        end
      end

      def render
        issues = errors
        return "OK #{pack.id} GTM" if issues.empty?

        issues.join("\n")
      end

      private

      def validate_account(account, dimensions)
        errors = []
        account_id = account.fetch("id", "unknown")
        if account.dig("priority", "tier").to_i == 1
          %w[date type source].each do |key|
            errors << "#{account_id}: Tier-1 trigger missing #{key}" unless present?(account.dig("trigger", key))
          end
        end

        %w[first_offer next_action confidence source_ledger].each do |key|
          errors << "#{account_id}: missing #{key}" unless present?(account[key])
        end

        components = account.fetch("score_components", {})
        dimensions.each do |dimension|
          errors << "#{account_id}: score component #{dimension} missing score" unless present?(components.dig(dimension, "score"))
          errors << "#{account_id}: score component #{dimension} missing evidence" unless present?(components.dig(dimension, "evidence"))
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
end
