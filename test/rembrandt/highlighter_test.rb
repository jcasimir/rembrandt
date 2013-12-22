require 'minitest/autorun'
require 'minitest/pride'
require './lib/rembrandt/highlighter'

class HighlighterTest < Minitest::Test
  def test_it_exists
    assert Rembrandt::Highlighter
  end
end