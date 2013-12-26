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

    def self.engine_priority=(engines)
      @engine_priority = engines
    end

    def self.engine_priority
      @engine_priority || library_default_engine_priority
    end

    def self.library_default_engine_priority
      [Engines::Pygmentize, Engines::WebService]
    end
  end
end