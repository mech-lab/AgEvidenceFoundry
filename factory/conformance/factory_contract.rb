# frozen_string_literal: true

require_relative "company_pack_contract"
require_relative "../loaders/company_pack_loader"

module Factory
  class FactoryContract
    attr_reader :loader

    def initialize(root: VenturePack.repo_root)
      @loader = CompanyPackLoader.new(root: root)
    end

    def validate
      errors = []
      errors << "no venture packs found" if loader.ids.empty?
      loader.all.each do |pack|
        errors.concat(CompanyPackContract.new(pack).validate)
      end
      errors
    end

    def validate!
      errors = validate
      raise VenturePackContract::ValidationError, errors.join("\n") if errors.any?

      true
    end
  end
end
