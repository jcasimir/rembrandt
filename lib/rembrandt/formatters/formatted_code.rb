module Rembrandt
  module Formatters
    class FormattedCode
      attr_reader :code, :language

      def initialize(input_code, input_language)
        @code = extract_code_from_html(input_code)
        @language = input_language
      end

      def line_count
        code.lines.count
      end

      def extract_code_from_html(input)
        matches = input.match(/<pre>(.+)<\/pre>/m)
        matches[1] if matches
      end
    end
  end
end