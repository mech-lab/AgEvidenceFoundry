# frozen_string_literal: true

require "date"
require "pathname"
require "yaml"
require_relative "company_pack"
require_relative "venture_pack_loader"

module Factory
  class CompanyPackLoader
    attr_reader :root, :venture_loader

    def initialize(root: CompanyPack.repo_root)
      @root = Pathname(root).expand_path
      @venture_loader = VenturePackLoader.new(root: @root)
    end

    def ids
      return [] unless ventures_dir.directory?

      ventures_dir.children
                  .select { |child| child.directory? && child.join("company.yml").file? }
                  .map { |child| child.basename.to_s }
                  .sort
    end

    def all
      ids.map { |id| load(id) }
    end

    def load(id)
      normalized_id = id.to_s.strip
      raise ArgumentError, "company pack id is required" if normalized_id.empty?

      path = ventures_dir.join(normalized_id)
      manifest = path.join("company.yml")
      raise KeyError, "unknown company pack #{normalized_id}" unless manifest.file?

      data = YAML.safe_load(manifest.read, permitted_classes: [Date, Time], aliases: false) || {}
      CompanyPack.new(path: path, data: data, product_pack: venture_loader.load(normalized_id))
    end

    def ventures_dir
      root.join("ventures")
    end
  end
end
