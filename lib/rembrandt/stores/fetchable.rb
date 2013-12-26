module Rembrandt
  module Stores
    module Fetchable
      def key_for(input, language)
        Digest::MD5.hexdigest(input + language)
      end

      def fetch(input, language)
        result = read key_for(input, language)
        if result.nil? && block_given?
          data_to_store = yield
          write(key_for(input, language), data_to_store)
          return data_to_store
        end
      end
    end
  end
end