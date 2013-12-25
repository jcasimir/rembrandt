require 'fileutils'
require 'digest/md5'

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

      def fetch(data, type)
        result = read(key_for(data, type))
        if result.nil? && block_given?
          data_to_store = yield
          write(key_for(data, type), data_to_store)
          return data_to_store
        end
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

      def key_for(input, language)
        Digest::MD5.hexdigest(input + language)
      end

      def flush
        `rm -rf #{output_directory}/*` if Dir.exist?(output_directory)
      end
    end
  end
end