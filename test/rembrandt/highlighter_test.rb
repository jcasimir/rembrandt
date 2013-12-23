require './test/test_helper'
require './lib/rembrandt'

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

  def test_it_defaults_to_pygmentize_if_available
    expected_engine = Rembrandt::Engines::Pygmentize
    expected_engine.stubs(:available?).returns(true)
    lighter = Rembrandt::Highlighter.new
    assert_equal expected_engine, lighter.engine.class
  end

  def test_it_uses_the_web_engine_if_pygmentize_is_not_available
    Rembrandt::Engines::Pygmentize.stubs(:available?).returns(false)
    Rembrandt::Engines::WebService.stubs(:available?).returns(true)
    expected_engine = Rembrandt::Engines::WebService
    lighter = Rembrandt::Highlighter.new
    assert_equal expected_engine, lighter.engine.class
  end
end