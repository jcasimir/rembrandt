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

      def language
        'ruby'
      end

      def extract_code_from_html(input)
        input.match(/<pre>(.+)<\/pre>/m)[1]
      end
    end
  end
end