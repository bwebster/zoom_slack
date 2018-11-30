# frozen_string_literal: true

RSpec.describe ZoomSlack::ProfileUpdater do
  let(:token) { "abc123" }
  let(:status) { ZoomSlack::Status.new(text: "foo", emoji: ":bar:", expires: 0) }

  subject { described_class.new(token: token) }

  describe "#status" do
    let(:expected_body) do
      {
        profile: {
          status_text: status.text,
          status_emoji: status.emoji,
          status_expiration: status.expires
        }
      }
    end
    let(:expected_headers) do
      {
        "Authorization" => "Bearer #{token}",
        "Content-Type" => "application/json;charset=utf-8"
      }
    end
    let(:expected_response_body) { JSON.generate(ok: true) }

    before do
      stub_request(:post, "https://slack.com/api/users.profile.set").
        with(body: expected_body, headers: expected_headers).
        to_return(status: 200, body: expected_response_body)
    end

    it "makes authenticated request to update profile" do
      subject.status(status)

      expect(
        a_request(:post, "https://slack.com/api/users.profile.set").
          with(body: expected_body, headers: expected_headers)
      ).to have_been_made.once
    end

    context "when request fails" do
      let(:expected_response_body) { JSON.generate(ok: false) }
      let(:stderr) { double("STDERR", print: true) }

      subject { described_class.new(token: token, stderr: stderr) }

      it "prints error to STDOUT" do
        subject.status(status)

        expect(
          a_request(:post, "https://slack.com/api/users.profile.set").
            with(body: expected_body, headers: expected_headers)
        ).to have_been_made.once
        expect(stderr).to have_received(:print).with("Unable to update Slack profile. Did you pass in the right token?\n")
      end
    end
  end
end
