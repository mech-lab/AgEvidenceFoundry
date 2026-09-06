# frozen_string_literal: true

module Factory
  module Operations
    class GtmScorer
      attr_reader :pack

      def initialize(pack)
        @pack = pack
      end

      def rows
        pack.accounts.map do |account|
          score = score_for(account)
          account.merge(
            "computed_score" => score,
            "computed_tier" => tier_for(score)
          )
        end.sort_by { |account| -account["computed_score"] }
      end

      def render
        lines = ["#{pack.name} GTM account score"]
        rows.each_with_index do |account, index|
          name = account.dig("organization", "name") || account["id"]
          lines << "#{index + 1}. #{name} #{account['computed_score']} Tier #{account['computed_tier']}"
        end
        lines.join("\n")
      end

      private

      def score_for(account)
        account.fetch("score_components", {})
               .values
               .map { |component| component["score"].to_i }
               .reduce(0, :+)
      end

      def tier_for(score)
        case score
        when 80..100
          1
        when 65..79
          2
        when 50..64
          3
        when 35..49
          4
        else
          5
        end
      end
    end
  end
end
