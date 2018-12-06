# frozen_string_literal: true

require "tmpdir"
require "open3"

module ZoomSlack
  module ProcessDetector
    class Mac < Base
      SCRIPT = "in_zoom_meeting.applescript"
      COMPILED_SCRIPT = "in_zoom_meeting.scptd"

      def initialize(open: Open3)
        self.open = open
      end

      def running?
        compile
        process_running?
      end

      def clean
        FileUtils.remove_dir(compiled_path) if Dir.exist?(compiled_path)
      end

      private

      attr_accessor :open

      def compile
        return if Dir.exist?(compiled_path)

        out, _err, _st = open.capture3("osacompile", "-o", compiled_path, source_path)
        out
      end

      def process_running?
        out, _err, _st = open.capture3("osascript", compiled_path)
        out.chomp == "true"
      end

      def compiled_path
        @bin_path ||= File.join(Dir.tmpdir, COMPILED_SCRIPT)
      end

      def source_path
        @source_path ||= File.join(File.dirname(__FILE__), "source", SCRIPT)
      end
    end
  end
end
