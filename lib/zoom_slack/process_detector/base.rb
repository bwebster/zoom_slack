# frozen_string_literal: true

module ZoomSlack
  module ProcessDetector
    # Factory method to get platform-specific implementation
    def self.for_platform
      Mac.new
    end

    class Base
      def running?
        raise NotImplementedError
      end
    end
  end
end
