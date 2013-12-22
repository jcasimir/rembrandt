module Rembrandt
  class Highlighter
    def default_language
      "ruby"
    end

    def highlight(input, language = default_language)
      input
    end
  end
end