require 'minitest/autorun'
require 'minitest/pride'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/support/vcr_cassettes'
  c.hook_into :webmock
end

class CodeHighlightTest < Minitest::Test
  def assert_highlight(filename, language)
    input = File.read("./test/support/#{filename}")
    expected = File.read("./test/support/#{filename}.html")
    assert_equal expected, highlighter.highlight(input, language)
  end
end