require './test/test_helper'
require './lib/rembrandt/language_normalizer'

class LanguageNormalizerTest < CodeHighlightTest
  attr_reader :normalizer

  def setup
    @normalizer = Rembrandt::LanguageNormalizer.new
  end

  def test_it_processes_a_known_variant
    assert_equal 'ruby', normalizer.process('ru')
    assert_equal 'objc', normalizer.process('m')
    assert_equal 'yaml', normalizer.process('yml')
  end

  def test_it_cannot_process_an_unknown_language
    assert_raises(ArgumentError){
      normalizer.process('asdf')
    }
  end
end
