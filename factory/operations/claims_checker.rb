# frozen_string_literal: true

require "find"
require "pathname"

module Factory
  module Operations
    class ClaimsChecker
      DEFAULT_EXTENSIONS = %w[.md .txt .yml .yaml .html .erb].freeze

      attr_reader :pack, :paths

      def initialize(pack, paths: [])
        @pack = pack
        @paths = paths.map { |path| Pathname(path) }
      end

      def findings
        phrases = Array(pack.claim_discipline["prohibited"])
        files.flat_map do |file|
          next [] unless file.file?

          text = file.read
          phrases.each_with_object([]) do |phrase, matches|
            next unless text.match?(/#{Regexp.escape(phrase)}/i)

            matches << "#{file}: prohibited claim phrase #{phrase.inspect}"
          end
        end
      end

      def render
        found = findings
        return "OK #{pack.id} claims check" if found.empty?

        found.join("\n")
      end

      private

      def files
        explicit = paths.flat_map { |path| expand_path(path) }
        return explicit if explicit.any?

        expand_path(pack.path.join("generated"))
      end

      def expand_path(path)
        path = Pathname(path)
        return [] unless path.exist?
        return [path] if path.file? && DEFAULT_EXTENSIONS.include?(path.extname)

        results = []
        Find.find(path.to_s) do |candidate|
          candidate_path = Pathname(candidate)
          next unless candidate_path.file?
          next unless DEFAULT_EXTENSIONS.include?(candidate_path.extname)

          results << candidate_path
        end
        results
      end
    end
  end
end
