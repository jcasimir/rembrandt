require 'digest/md5'
require 'redis'

module Rembrandt
  module Stores
    class Redis
      attr_reader :database

      def initialize
        @database = ::Redis.new
      end

      def available?
        defined?(::Redis)
      end

      def write(key, data)
        database.set(key, data)
      end

      def read(key)
        database.get(key)
      end

      def fetch(input, language)
        result = read key_for(input, language)
        if result.nil? && block_given?
          data_to_store = yield
          write(key_for(input, language), data_to_store)
          return data_to_store
        end
      end

      def flush
        database.flushdb
      end

      def key_for(input, language)
        Digest::MD5.hexdigest(input + language)
      end
    end
  end
end
