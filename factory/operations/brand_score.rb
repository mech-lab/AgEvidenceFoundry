# frozen_string_literal: true

module Factory
  module Operations
    class BrandScore
      TEST_ORDER = %w[
        buyer_recognition
        role_discipline
        land_motion_fit
        expansion_permission
        investor_signal
      ].freeze

      attr_reader :pack

      def initialize(pack)
        @pack = pack
      end

      def rows
        tests = pack.naming.fetch("tests", {})
        TEST_ORDER.map do |id|
          test = tests.fetch(id, {})
          {
            "id" => id,
            "question" => test["question"],
            "score" => test["score"].to_i,
            "evidence" => Array(test["evidence"])
          }
        end
      end

      def total
        rows.map { |row| row["score"] }.reduce(0, :+)
      end

      def maximum
        TEST_ORDER.length * 5
      end

      def percentage
        return 0 if maximum.zero?

        ((total.to_f / maximum) * 100).round
      end

      def render
        output = []
        output << "#{pack.name} brand score: #{total}/#{maximum} (#{percentage}%)"
        rows.each do |row|
          output << "#{row['id']}: #{row['score']}/5"
        end
        output.join("\n")
      end
    end
  end
end
