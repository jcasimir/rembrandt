require './test/test_helper'
require './lib/rembrandt/formatters/formatted_code'

class FormattedCodeTest < CodeHighlightTest
  def test_it_counts_lines
    input = File.read('./test/support/ruby_sample_1.rb.html')
    code = Rembrandt::Formatters::FormattedCode.new(input, 'ruby')
    assert_equal 5, code.line_count
  end

  def test_it_stores_the_language
    input = File.read('./test/support/python_sample_1.py.html')
    code = Rembrandt::Formatters::FormattedCode.new("", 'python')
    assert_equal 'python', code.language
  end
end
