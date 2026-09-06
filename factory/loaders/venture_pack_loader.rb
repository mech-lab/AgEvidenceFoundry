# frozen_string_literal: true

require "date"
require "pathname"
require "yaml"
require_relative "venture_pack"

module Factory
  class VenturePackLoader
    attr_reader :root

    def initialize(root: VenturePack.repo_root)
      @root = Pathname(root).expand_path
    end

    def ids
      return [] unless ventures_dir.directory?

      ventures_dir.children
                  .select { |child| child.directory? && manifest_for(child.basename.to_s).file? }
                  .map { |child| child.basename.to_s }
                  .sort
    end

    def all
      ids.map { |id| load(id) }
    end

    def load(id)
      normalized_id = id.to_s.strip
      raise ArgumentError, "venture id is required" if normalized_id.empty?

      company_path = ventures_dir.join(normalized_id)
      path = product_dir_for(normalized_id)
      manifest = manifest_for(normalized_id)
      raise KeyError, "unknown venture pack #{normalized_id}" unless manifest.file?

      data = read_yaml(manifest)
      data["terminology"] = read_yaml(path.join("terminology.yml")).merge(data.fetch("terminology", {}))
      data["features"] = read_yaml(path.join("features.yml")).fetch("features", {}).merge(data.fetch("features", {}))

      VenturePack.new(path: path, data: data)
    end

    def ventures_dir
      root.join("ventures")
    end

    def product_dir_for(id)
      company_path = ventures_dir.join(id)
      product_path = company_path.join("product")
      product_path.directory? ? product_path : company_path
    end

    def manifest_for(id)
      product_dir_for(id).join("venture.yml")
    end

    private

    def read_yaml(path)
      return {} unless path.file?

      Factory.deep_stringify(YAML.safe_load(path.read, permitted_classes: [Date, Time], aliases: false) || {})
    end
  end
end
