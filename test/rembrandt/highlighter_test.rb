require 'minitest/autorun'
require 'minitest/pride'
require './lib/rembrandt/highlighter'

class HighlighterTest < Minitest::Test
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
end