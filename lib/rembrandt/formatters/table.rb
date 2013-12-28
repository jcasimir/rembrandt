require 'erb'
require 'tilt'
require_relative 'formatted_code'

module Rembrandt
  module Formatters
    class Table
      def format(input_code, input_language)
        template.render FormattedCode.new(input_code, input_language)
      end

      def template
        @template ||= Tilt.new('./lib/rembrandt/formatters/templates/table.erb', :trim => true)
      end
    end
  end
end