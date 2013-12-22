module Rembrandt
  module Engines
    class Pygmentize
      def highlight(input, language)
        tmp_file = File.open(".colorize_temp", "w")
        tmp_file.write(input)
        tmp_file.close
        output = `pygmentize -f html -l #{language} .colorize_temp`
        `rm .colorize_temp`
        output
      end
    end
  end
end