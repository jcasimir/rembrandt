require './test/test_helper'
require './lib/rembrandt/highlighter'

class HighlighterTest < CodeHighlightTest
  def test_it_exists
    assert Rembrandt::Highlighter
  end

  attr_reader :highlighter

  def setup
    @highlighter = Rembrandt::Highlighter.new
  end

  def test_it_has_a_highlight_method
    assert highlighter.highlight("Hello, World")
  end

  def test_highlight_takes_an_input_and_a_language
    assert highlighter.highlight("Hello, World", 'ruby')
  end

  def test_highlight_properly_highlights_ruby
    assert_highlight 'ruby_sample_1.rb', 'ruby'
  end

  def test_highlight_properly_highlights_python
    assert_highlight 'python_sample_1.py', 'python'
  end

  class StubEngine
    def highlight(text, language)
      "stub highlight"
    end
  end

  def test_the_highlight_engine_is_configurable
    stubbed_highlighter = Rembrandt::Highlighter.new(StubEngine)
    assert_equal "stub highlight", stubbed_highlighter.highlight("hello", "ruby")
  end
end