require_relative 'engines/pygments_known_languages'

module Rembrandt
  class LanguageNormalizer
    include Engines::PygmentsKnownLanguages

    def known_language?(input)
      known_languages.detect{|lang| lang == input}
    end

    def known_variant?(input)
      known_variants[input]
    end

    def known_variants
      {'ru'  => 'ruby',
       'm'   => 'objc',
       'yml' => 'yaml'}
    end

    def process(input)
      known_language?(input) || known_variant?(input) || raise_exception(input)
    end

    def raise_exception(input)
      raise ArgumentError.new("Unknown language specifier: #{input}")
    end
  end
end