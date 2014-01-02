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
        @template ||= Tilt.new(template_path, :trim => true)
      end

      def template_path
        File.expand_path(File.join(File.dirname(__FILE__), "./templates/table.erb"))
      end
    end
  end
end