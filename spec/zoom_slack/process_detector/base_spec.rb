# frozen_string_literal: true

RSpec.describe ZoomSlack::ProcessDetector::Base do
  describe ".for_platform" do
    it "should return Mac instance" do
      expect(ZoomSlack::ProcessDetector.for_platform).to be_instance_of(ZoomSlack::ProcessDetector::Mac)
    end
  end
  
  describe "#running" do
    it "should raise exception" do
      expect { subject.running? }.to raise_error(NotImplementedError)
    end
  end
end
