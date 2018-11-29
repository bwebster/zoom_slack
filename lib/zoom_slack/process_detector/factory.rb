# frozen_string_literal: true

module ZoomSlack
  module ProcessDetector
    # Factory method to get platform-specific implementation
    def self.for_platform
      Mac.new
    end
  end
end
