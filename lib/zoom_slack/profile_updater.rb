# frozen_string_literal: true

require "faraday"
require "json"

module ZoomSlack
  class ProfileUpdater
    def initialize(token:)
      self.token = token
    end

    def status(status)
      update_profile status
    end

    private

    attr_accessor :token

    def update_profile(status)
      response = connection.post do |req|
        req.url "/api/users.profile.set"
        req.headers["Content-Type"] = "application/json;charset=utf-8"
        req.body = JSON.generate(profile: {
          status_text: status.text,
          status_emoji: status.emoji,
          status_expiration: status.expires
        })
      end
      human_readable_error response
    end

    def human_readable_error(response)
      json = JSON.parse(response.body)
      puts "Unable to update Slack profile. Did you pass in the right token?" unless json.fetch("ok")
    end

    def connection
      Faraday.new(url: "https://slack.com") do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.authorization :Bearer, token
      end
    end
  end
end
