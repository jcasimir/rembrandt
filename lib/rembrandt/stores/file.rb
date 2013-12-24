require 'fileutils'

module Rembrandt
  module Stores
    class File
      attr_reader :output_directory

      def initialize(directory)
        @output_directory = directory
        create_directory
      end

      def create_directory
        FileUtils.mkdir_p output_directory
      end
    end
  end
end