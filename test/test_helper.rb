require 'minitest/autorun'
require 'minitest/pride'

class CodeHighlightTest < Minitest::Test
  def assert_highlight(filename, language)
    input = File.read("./test/support/#{filename}")
    expected = File.read("./test/support/#{filename}.html")
    assert_equal expected, highlighter.highlight(input, language)
  end
end