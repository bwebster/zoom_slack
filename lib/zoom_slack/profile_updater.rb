# frozen_string_literal: true

require "faraday"
require "json"

module ZoomSlack
  class ProfileUpdater
    def initialize(token: ENV.fetch("SLACK_API_TOKEN"))
      self.token = token
    end

    def status(status)
      connection.post do |req|
        req.url "/api/users.profile.set"
        req.headers["Content-Type"] = "application/json;charset=utf-8"
        req.body = JSON.generate(profile: {
          status_text: status.text,
          status_emoji: status.emoji,
          status_expiration: status.expires
        })
      end
    end

    private

    attr_accessor :token

    def connection
      Faraday.new(url: "https://slack.com") do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.authorization :Bearer, token
      end
    end
  end
end
