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
    result = highlighter.highlight("Hello, World", 'ruby')
    assert result, "Got: #{result}"
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

  class StubStore
    def write(key, data)
      true
    end

    def fetch(input, language)
      true
    end

    def flush
      true
    end
  end

  def test_it_uses_a_datastore
    lighter = Rembrandt::Highlighter.new(StubEngine)
    store = StubStore.new
    highlighter.store = store
    store.expects(:fetch).once
    highlighter.highlight("Hello, World")
  end

  def test_it_uses_the_default_language_from_config
    Rembrandt::Config.default_language = "python"
    assert_equal "python", highlighter.default_language
  end

  def test_it_uses_the_engine_prioritization_from_config
    preferred = [Rembrandt::Engines::Pygmentize]
    Rembrandt::Config.engine_priority = preferred
    assert_equal preferred, highlighter.engines
  end

  def teardown
    highlighter.store.flush
  end
end