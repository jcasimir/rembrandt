require 'uri'

module Rembrandt
  module Engines
    class WebService
      def highlight(input, language)
        Net::HTTP.post_form(url, {'lang'=>language, 'code'=>input}).body
      end

      def url
        @url ||= URI.parse('http://pygmentize.herokuapp.com/')
      end
    end
  end
end