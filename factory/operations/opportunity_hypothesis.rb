# frozen_string_literal: true

module Factory
  module Operations
    class OpportunityHypothesis
      attr_reader :pack, :account_id

      def initialize(pack, account_id:)
        @pack = pack
        @account_id = account_id.to_s
      end

      def render
        account = pack.accounts.find { |item| item["id"] == account_id }
        raise KeyError, "unknown account #{account_id} for #{pack.id}" unless account

        template = default_template
        replacements = {
          "account.name" => account.dig("organization", "name"),
          "trigger.description" => account.dig("trigger", "description"),
          "evidence_need" => account.dig("evidence_problem", "hypothesis"),
          "company.name" => pack.name,
          "artifact.name" => pack.product_pack.reliance["artifact"],
          "buyer.role" => account.dig("buyer_map", "economic_buyer_role") || "the accountable buyer",
          "reliance_event" => pack.reliance["event"]
        }

        replacements.reduce(template) do |text, (key, value)|
          text.gsub("{{ #{key} }}", value.to_s)
        end
      end

      private

      def default_template
        "Because {{ account.name }} is currently {{ trigger.description }}, it must {{ evidence_need }}. " \
          "{{ company.name }} can provide {{ artifact.name }}, initially sold to {{ buyer.role }} around {{ reliance_event }}."
      end
    end
  end
end
