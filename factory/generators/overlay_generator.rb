# frozen_string_literal: true

module Factory
  class OverlayGenerator
    def call(*)
      raise NotImplementedError, "pack-aware Rails overlays are scheduled for phase F6"
    end
  end
end
