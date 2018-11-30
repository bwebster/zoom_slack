# frozen_string_literal: true

RSpec.describe ZoomSlack::Syncer do
  let(:token) { "abc123" }
  let(:profile_updater) { instance_spy(ZoomSlack::ProfileUpdater) }
  let(:process_detector) { instance_spy(ZoomSlack::ProcessDetector::Base) }

  subject { described_class.new(token: token, profile_updater: profile_updater, process_detector: process_detector) }

  describe "#sync" do
    context "zoom process is running" do
      before { allow(process_detector).to receive(:running?).and_return(true) }

      it "updates profile with meeting status" do
        subject.sync

        expect(profile_updater).to have_received(:status) do |status|
          expect(status.text).to eq("In a meeting")
          expect(status.emoji).to eq(":spiral_calendar_pad:")
          expect(status.expires).to eq(0)
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
