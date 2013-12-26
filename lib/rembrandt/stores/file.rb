require 'fileutils'
require 'digest/md5'
require_relative 'fetchable'

module Rembrandt
  module Stores
    class File
      include Fetchable
      attr_reader :output_directory

      def initialize(directory = nil)
        self.output_directory = directory || Config.file_store_directory
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
        filename = filename_for(key)
        if ::File.exist?(filename)
          ::File.read(filename_for(key))
        end
      end

      def filename_for(key)
        output_directory + prefix + key
      end

      def prefix
        'rembrandt_'
      end

      def flush
        `rm -rf #{output_directory}/*` if Dir.exist?(output_directory)
      end
    end
  end
end