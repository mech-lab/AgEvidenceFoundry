# frozen_string_literal: true

module Factory
  module Operations
    class ValidationReport
      EVIDENCE_LEVELS = %w[P0 P1 P2 P3 P4 P5].freeze

      attr_reader :pack

      def initialize(pack)
        @pack = pack
      end

      def render(mode = "show")
        case mode
        when "show"
          render_show
        when "interviews"
          render_interviews
        when "pricing"
          render_pricing
        when "gate"
          render_gate
        else
          raise KeyError, "unknown validation command #{mode}"
        end
      end

      def gate_result
        declared = pack.validation_gate.dig("phase_zero_gate", "outcome", "current")
        return declared if declared

        gate_passes? ? "PASS" : "ITERATE"
      end

      private

      def render_show
        synthesis = pack.validation_synthesis.fetch("phase_zero", {})
        pricing = pack.pricing_synthesis
        [
          "#{pack.name} - Phase 0",
          "PROBLEM",
          "  Interviews: #{synthesis.dig('sample', 'interviews').to_i}",
          "  Workflow reconstructions: #{synthesis.dig('problem', 'workflow_reconstructions').to_i}",
          "RELIANCE",
          "  Consequential decisions: #{synthesis.dig('reliance', 'consequential_decision_confirmations').to_i}",
          "BUYER",
          "  Economic buyer supported: #{yes_no(synthesis.dig('buyer', 'economic_buyer_hypothesis_supported'))}",
          "ARTIFACT",
          "  Artifact tests: #{synthesis.dig('artifact', 'artifact_tests').to_i}",
          "PRICING",
          "  Evidence level: #{pricing['pricing_evidence_level']}",
          "  Price-tested organizations: #{pricing.dig('sample', 'organizations_price_tested').to_i}",
          "  Budget owner confirmations: #{pricing.dig('buyer_evidence', 'budget_owner_confirmed').to_i}",
          "  Strongest signal: #{strongest_pricing_signal}",
          "RESULT",
          "  #{gate_result} -> #{synthesis.dig('decision', 'next_phase') || 'continue_validation'}"
        ].join("\n")
      end

      def render_interviews
        lines = ["#{pack.name} Phase 0 interviews"]
        if pack.validation_interviews.empty?
          lines << "No interviews recorded"
          return lines.join("\n")
        end

        pack.validation_interviews.each do |interview|
          lines << "#{interview['id']} #{interview['status']} #{interview['target_account']} pricing=#{interview.dig('pricing', 'pricing_evidence_level')} confidence=#{interview.dig('pricing', 'confidence')}"
        end
        lines.join("\n")
      end

      def render_pricing
        hypothesis = pack.pricing_hypothesis
        policy = pack.pricing_policy
        synthesis = pack.pricing_synthesis
        range = hypothesis.dig("initial_hypothesis", "price_range") || {}
        land = policy.fetch("land", {})
        [
          "#{pack.name} Phase 0 pricing",
          "Status: #{hypothesis['status']}",
          "Initial range: #{hypothesis['currency']} #{range['minimum']}-#{range['maximum']}",
          "Current land offer: #{land['offer']}",
          "Current land range: #{policy['currency']} #{land.dig('range', 'minimum')}-#{land.dig('range', 'maximum')}",
          "Primary value metric: #{policy['primary_value_metric']}",
          "Secondary value metric: #{policy['secondary_value_metric']}",
          "Evidence level: #{synthesis['pricing_evidence_level']}",
          "Evidence ladder: #{EVIDENCE_LEVELS.map { |level| "#{level}=#{synthesis.dig('evidence', level).to_i}" }.join(' ')}",
          "Decision: #{synthesis.dig('decision', 'action')}"
        ].join("\n")
      end

      def render_gate
        gate = pack.validation_gate.fetch("phase_zero_gate", {})
        pricing = gate.fetch("pricing", {})
        [
          "#{pack.name} Phase 0 gate",
          "Problem organizations required: #{gate.dig('problem', 'distinct_organizations')}",
          "Reliance confirmations required: #{gate.dig('reliance', 'relying_party_confirmations')}",
          "Artifact tests required: #{gate.dig('artifact', 'artifact_tests')}",
          "Pricing evidence required: #{pricing.dig('minimum_evidence_level', 'level')} from #{pricing.dig('minimum_evidence_level', 'organizations')} organizations",
          "Strong pricing signal required: #{Array(pricing.dig('required_strong_signal', 'one_of')).join(' or ')}",
          "Current result: #{gate_result}"
        ].join("\n")
      end

      def gate_passes?
        synthesis = pack.validation_synthesis.fetch("phase_zero", {})
        pricing = pack.pricing_synthesis
        gate = pack.validation_gate.fetch("phase_zero_gate", {})
        pricing_gate = gate.fetch("pricing", {})
        min_level = pricing_gate.dig("minimum_evidence_level", "level") || "P2"
        min_orgs = pricing_gate.dig("minimum_evidence_level", "organizations").to_i
        strong_signals = Array(pricing_gate.dig("required_strong_signal", "one_of"))

        synthesis.dig("problem", "distinct_organizations").to_i >= gate.dig("problem", "distinct_organizations").to_i &&
          synthesis.dig("problem", "workflow_reconstructions").to_i >= gate.dig("problem", "workflow_reconstructions").to_i &&
          synthesis.dig("reliance", "relying_party_confirmations").to_i >= gate.dig("reliance", "relying_party_confirmations").to_i &&
          synthesis.dig("artifact", "artifact_tests").to_i >= gate.dig("artifact", "artifact_tests").to_i &&
          evidence_at_or_above(min_level) >= min_orgs &&
          strong_signals.any? { |level| pricing.dig("evidence", level).to_i.positive? }
      end

      def evidence_at_or_above(level)
        start = EVIDENCE_LEVELS.index(level) || 0
        EVIDENCE_LEVELS[start..].sum { |item| pack.pricing_synthesis.dig("evidence", item).to_i }
      end

      def strongest_pricing_signal
        EVIDENCE_LEVELS.reverse.find { |level| pack.pricing_synthesis.dig("evidence", level).to_i.positive? } || "none"
      end

      def yes_no(value)
        value == true ? "yes" : "no"
      end
    end
  end
end
