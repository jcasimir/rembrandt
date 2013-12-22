module Rembrandt
  class Highlighter
    def default_language
      "ruby"
    end

    def highlight(input, language = default_language)
      tmp_file = File.open("./tmp/colorize_temp", "w")
      tmp_file.write(input)
      tmp_file.close
      `pygmentize -f html -l #{language} ./tmp/colorize_temp`
    end
  end
end