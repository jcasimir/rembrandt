module Rembrandt
  module Engines
    class Pygmentize
      def highlight(input, language)
        tmp_file = File.open(".colorize_temp", "w")
        tmp_file.write(input)
        tmp_file.close
        output = `pygmentize -f html -l #{language} -O encoding=utf8 .colorize_temp`
        `rm .colorize_temp`
        output
      end

      def self.available?
        present_on_system?
      end

      def self.present_on_system?
        !`which pygmentize`.empty?
      end
      
    end
  end
end