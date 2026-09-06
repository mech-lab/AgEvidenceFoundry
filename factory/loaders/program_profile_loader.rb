# frozen_string_literal: true

require_relative "venture_pack"

module Factory
  class ProgramProfileLoader
    attr_reader :pack

    def initialize(pack)
      @pack = pack
    end

    def profiles
      pack.program_profile_files
    end

    def declared_ids
      pack.program_profiles
    end

    def file_ids
      profiles.map { |profile| profile["id"] }.compact
    end
  end
end
