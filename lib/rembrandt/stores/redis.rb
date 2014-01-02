require 'digest/md5'
require 'redis'
require_relative 'fetchable'

module Rembrandt
  module Stores
    class Redis
      include Fetchable
      attr_reader :database, :url

      def initialize(url = nil)
        @url = ENV['REMBRANDT_REDIS_URL']
        @database = ::Redis.new(:url => url)
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
        database.flushdb
      end
    end
  end
end
