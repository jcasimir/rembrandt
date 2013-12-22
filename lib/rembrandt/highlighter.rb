require_relative 'engines/pygmentize'

module Rembrandt
  class Highlighter
    attr_reader :engine

    def initialize(input_engine = nil)
      @engine = (input_engine || default_engine).new
    end

    def default_language
      "ruby"
    end

    def default_engine
      Engines::Pygmentize
    end

    def highlight(input, language = default_language)
      engine.highlight(input, language)
    end
  end
end