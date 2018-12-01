# frozen_string_literal: true

require "fileutils"

RSpec.describe ZoomSlack::ProcessDetector::Mac do
  let(:open) { class_spy(Open3) }
  let(:compiled_path) { File.join(Dir.tmpdir, ZoomSlack::ProcessDetector::Mac::COMPILED_SCRIPT) }
  let(:source_path) { File.join(File.dirname(__FILE__).gsub("spec", "lib"), "source", ZoomSlack::ProcessDetector::Mac::SCRIPT) }

  subject { described_class.new(open: open) }

  after { remove_compiled }

  def remove_compiled
    FileUtils.remove_dir(compiled_path, true)
  end

  def make_compiled
    Dir.mkdir(compiled_path) unless Dir.exist?(compiled_path)
  end

  describe "#running?" do
    describe "compiling the source script" do
      before do
        remove_compiled
        allow(open).to receive(:capture3).with("osascript", compiled_path).and_return(["", nil, nil])
      end

      it "should compile" do
        expect(open).to receive(:capture3).with("osacompile", "-o", compiled_path, source_path)

        subject.running?
      end

      context "compiled script already exists" do
        before { make_compiled }

        it "should not recompile" do
          expect(open).not_to receive(:capture3).with("osacompile", "-o", kind_of(String), kind_of(String))

          subject.running?
        end
      end
    end

    describe "executes script" do
      before { make_compiled }

      it "script returns true" do
        expect(open).to receive(:capture3).with("osascript", compiled_path).and_return(["true\n", nil, nil])

        expect(subject.running?).to be_truthy
      end

      it "script returns false" do
        expect(open).to receive(:capture3).with("osascript", compiled_path).and_return(["false\n", nil, nil])

        expect(subject.running?).to be_falsey
      end
    end
  end
end
