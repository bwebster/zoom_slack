# frozen_string_literal: true

RSpec.describe ZoomSlack::Config do
  describe "#token" do
    context "env includes SLACK_API_TOKEN" do
      let(:token) { "abc123" }

      around do |example|
        ClimateControl.modify(SLACK_API_TOKEN: token) { example.run }
      end

      it "sets token from env" do
        expect(subject.token).to eq(token)
      end
    end
  end

  describe "#meeting_expires_at" do
    let(:now) { Time.now }

    around do |example|
      Timecop.freeze(now) { example.run }
    end

    it "returns current time + meeting_expires_in_min" do
      subject.meeting_expires_in_min = 10
      expect(subject.meeting_expires_at).to eq(now.to_i + (10 * 60))
    end

    context "meeting_expires_in_min is not set" do
      it "returns nil" do
        expect(subject.meeting_expires_at).to be_nil
      end
    end
  end
end
