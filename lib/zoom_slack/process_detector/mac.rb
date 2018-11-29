# frozen_string_literal: true

require "tmpdir"

module ZoomSlack
  module ProcessDetector
    class Mac
      def running?
        compile
        process_running?
      end

      private

      def compile
        `osacompile -o #{bin_path} #{source_path}` unless Dir.exist?(bin_path)
      end

      def process_running?
        `osascript #{bin_path}`.chomp == "true"
      end

      def bin_path
        @bin_path ||= File.join(Dir.tmpdir, "in_zoom_meeting.scptd")
      end

      def source_path
        @source_path ||= File.join(File.dirname(__FILE__), "source", "in_zoom_meeting.applescript")
      end
    end
  end
end
