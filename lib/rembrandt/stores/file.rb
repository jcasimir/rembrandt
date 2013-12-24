require 'fileutils'

module Rembrandt
  module Stores
    class File
      attr_reader :output_directory

      def initialize(directory)
        self.output_directory = directory
        create_directory
      end

      def output_directory=(name)
        name += '/' unless name.end_with?('/')
        @output_directory = name
      end

      def create_directory
        FileUtils.mkdir_p output_directory
      end

      def write(key, data)
        ::File.open( filename_for(key), "w" ) do |f|
          f.write(data)
        end
      end

      def read(key)
        ::File.read filename_for(key)
      end

      def filename_for(key)
        output_directory + prefix + key
      end

      def prefix
        'rembrandt_'
      end
    end
  end
end