require 'minitest/autorun'
require 'minitest/pride'
require './lib/rembrandt/highlighter'

class InOutTest < Minitest::Test
  def assert_highlight(filename, language)
    input = File.read("./test/support/#{filename}")
    expected = File.read("./test/support/#{filename}.html")
    assert_equal expected, highlighter.highlight(input, language)
  end
end

class HighlighterTest < InOutTest
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
end