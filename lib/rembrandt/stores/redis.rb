require 'digest/md5'
require 'redis'
require_relative 'fetchable'

module Rembrandt
  module Stores
    class Redis
      include Fetchable
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
        database.flushdb
      end

      # def connect_to_highlight_store
      #   host = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
      #   uri = URI.parse(host)
      #   store = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      #   puts "Connecting to highlight store #{store.inspect}"
      #   store
      # end
    end
  end
end
