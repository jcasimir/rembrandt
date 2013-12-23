require_relative 'engines/pygmentize'

module Rembrandt
  class Highlighter
    attr_reader :engine

    def initialize(input_engine = nil)
      @engine = (input_engine || autoselect_engine).new
    end

    def default_language
      "ruby"
    end

    def autoselect_engine
      [Engines::Pygmentize, Engines::WebService].detect(&:available?)
    end

    def highlight(input, language = default_language)
      engine.highlight(input, language)
    end
  end
end