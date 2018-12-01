# frozen_string_literal: true

RSpec.describe ZoomSlack::Syncer do
  let(:config) do
    ZoomSlack::Config.new.tap do |c|
      c.token = "abc123"
    end
  end
  let(:profile_updater) { instance_spy(ZoomSlack::ProfileUpdater) }
  let(:process_detector) { instance_spy(ZoomSlack::ProcessDetector::Base) }

  subject { described_class.new(config, profile_updater: profile_updater, process_detector: process_detector) }

  describe "#sync" do
    context "zoom process is running" do
      before { allow(process_detector).to receive(:running?).and_return(true) }

      it "updates profile with meeting status" do
        subject.sync

        expect(profile_updater).to have_received(:status) do |status|
          expect(status.text).to eq(config.meeting_text)
          expect(status.emoji).to eq(config.meeting_emoji)
          expect(status.expires).to be_nil
        end
      end

      context "config has expires set" do
        let(:now) { Time.now }

        before { config.meeting_expires_in_min = 10 }

        around do |example|
          Timecop.freeze(now) { example.run }
        end

        it "updates profile with expiration date in epoch seconds" do
          subject.sync

          expect(profile_updater).to have_received(:status) do |status|
            expect(status.expires).to eq(config.meeting_expires_at)
          end
        end
      end

      context "zoom process is not running" do
        before { allow(process_detector).to receive(:running?).and_return(false) }

        it "clears profile status" do
          subject.sync

          expect(profile_updater).to have_received(:status) do |status|
            expect(status.text).to be_nil
            expect(status.emoji).to be_nil
            expect(status.expires).to be_nil
          end
        end
      end
    end
  end
end
