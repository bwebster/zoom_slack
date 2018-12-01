# frozen_string_literal: true

module ZoomSlack
  class Syncer
    def initialize(config,
                   profile_updater: ProfileUpdater.new(token: config.token),
                   process_detector: ProcessDetector.for_platform)
      self.config = config
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

    attr_accessor :config, :profile_updater, :process_detector

    def in_meeting_status
      Status.new(text: config.meeting_text, emoji: config.meeting_emoji, expires: config.meeting_expires_at)
    end

    def clear_status
      Status.new(text: config.clear_text, emoji: config.clear_emoji)
    end
  end
end
