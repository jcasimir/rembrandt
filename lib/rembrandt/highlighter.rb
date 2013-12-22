require './lib/rembrandt/engines/pygmentize'

module Rembrandt
  class Highlighter
    def default_language
      "ruby"
    end

    def highlight(input, language = default_language)
      Engines::Pygmentize.new.highlight(input, language)
    end
  end
end