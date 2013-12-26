module Rembrandt
  class Config
    def self.default_language=(input)
      @default_language = input
    end

    def self.default_language
      @default_language || library_default_language
    end

    def self.library_default_language
      "ruby"
    end
  end
end