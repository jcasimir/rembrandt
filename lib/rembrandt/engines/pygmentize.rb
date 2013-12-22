module Rembrandt
  module Engines
    class Engines::Pygmentize
      def highlight(input, language)
        tmp_file = File.open("./tmp/colorize_temp", "w")
        tmp_file.write(input)
        tmp_file.close
        `pygmentize -f html -l #{language} ./tmp/colorize_temp`
      end
    end
  end
end