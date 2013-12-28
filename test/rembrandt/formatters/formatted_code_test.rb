require './test/test_helper'
require './lib/rembrandt/formatters/formatted_code'

class FormattedCodeTest < CodeHighlightTest
  def test_it_counts_lines
    input = File.read('./test/support/ruby_sample_1.rb.html')
    source = Rembrandt::Formatters::FormattedCode.new(input, 'ruby')
    assert_equal 5, source.line_count
  end
end
