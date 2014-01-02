require 'net/http'
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

      def self.available?
        site = Net::HTTP.new('pygmentize.herokuapp.com', 80)
        site.request_head('/').code == "200"
      end
    end
  end
end