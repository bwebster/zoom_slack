# frozen_string_literal: true

module ZoomSlack
  class Syncer
    def self.sync
      new.sync
    end

    def initialize(profile_updater: ProfileUpdater.new,
                   process_detector: ProcessDetector.for_platform)
      self.profile_updater = profile_updater
      self.process_detector = process_detector
    end

    def sync
      if process_detector.running?
        profile_updater.status in_meeting_status
      else
        profile_updater.status clear_status
      end
    end

    private

    attr_accessor :profile_updater, :process_detector

    def in_meeting_status
      Status.new(text: "In a meeting", emoji: ":spiral_calendar_pad:", expires: 0)
    end

    def clear_status
      Status.new
    end
  end
end
