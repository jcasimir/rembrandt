module Rembrandt
  class LanguageNormalizer
    def process(input)
      if input == 'ru'
        'ruby'
      else
        input
      end
    end
  end
end