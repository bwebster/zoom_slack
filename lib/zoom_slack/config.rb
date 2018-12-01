# frozen_string_literal: true

module ZoomSlack
  class Config
    TOKEN_DEFAULT_ENV = "SLACK_API_TOKEN"
    MEETING_TEXT_DEFAULT = "In a meeting"
    MEETING_EMOJI_DEFAULT = ":spiral_calendar_pad:"
    MEETING_EXPIRES_IN_MIN_DEFAULT = 0
    CLEAR_TEXT_DEFAULT = nil
    CLEAR_EMOJI_DEFAULT = nil

    attr_accessor :token,
                  :meeting_text, :meeting_emoji, :meeting_expires_in_min,
                  :clear_text, :clear_emoji

    def initialize
      self.token = ENV[TOKEN_DEFAULT_ENV]
      self.meeting_text = MEETING_TEXT_DEFAULT
      self.meeting_emoji = MEETING_EMOJI_DEFAULT
      self.meeting_expires_in_min = MEETING_EXPIRES_IN_MIN_DEFAULT
      self.clear_text = CLEAR_TEXT_DEFAULT
      self.clear_emoji = CLEAR_EMOJI_DEFAULT
    end

    def meeting_expires_in_min=(min)
      @meeting_expires_in_min = Integer(min)
    end

    def meeting_expires_at
      return nil if meeting_expires_in_min == 0

      Time.now.to_i + (meeting_expires_in_min * 60)
    end
  end
end
