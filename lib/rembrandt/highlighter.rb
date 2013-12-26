require_relative 'engines/pygmentize'
require_relative 'engines/web_service'
require_relative 'stores/file'
require_relative 'stores/redis'

module Rembrandt
  class Highlighter
    attr_reader :engine
    attr_writer :store

    def initialize(input_engine = nil)
      @engine = (input_engine || autoselect_engine).new
    end

    def store
      @store ||= autoselect_store
    end

    def default_language
      "ruby"
    end

    def autoselect_store
      redis = Stores::Redis.new
      if redis.available?
        redis
      else
        Stores::File.new('./tmp/.rembrandt_cache')
      end
    end

    def autoselect_engine
      [Engines::Pygmentize, Engines::WebService].detect(&:available?)
    end

    def highlight(input, language = default_language)
      store.fetch(input, language) do
        engine.highlight(input, language)
      end
    end
  end
end