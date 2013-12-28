require_relative 'engines/pygmentize'
require_relative 'engines/web_service'
require_relative 'stores/file'
require_relative 'stores/redis'
require_relative 'config'
require_relative 'language_normalizer'

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
      Config.default_language
    end

    def autoselect_store
      redis = Stores::Redis.new
      if redis.available?
        redis
      else
        Stores::File.new
      end
    end

    def engines
      Config.engine_priority
    end

    def autoselect_engine
      engines.detect(&:available?)
    end

    def highlight(input, input_language = default_language)
      language = normalize_language(input_language)
      store.fetch(input, language) do
        engine.highlight(input, language)
      end
    end

    def highlight_file(filename, language = default_language)
      data = File.read(filename)
      highlight(data, language)
    end

    def normalize_language(input)
      language_normalizer.process(input)
    end

    def language_normalizer
      @language_normalizer ||= LanguageNormalizer.new
    end
  end
end