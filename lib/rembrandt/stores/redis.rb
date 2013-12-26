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

      def flush

      end

      def key_for(input, language)
        Digest::MD5.hexdigest(input + language)
      end
    end
  end
end
