require './test/test_helper'
require './lib/rembrandt/formatters/table'

class FormattersTableTest < CodeHighlightTest
  attr_reader :formatter

  def setup
    @formatter = Rembrandt::Formatters::Table.new
  end

  def test_it_exists
    assert Rembrandt::Formatters::Table.new
  end

  def test_it_tableizes
    input = File.read('./test/support/ruby_sample_2.rb.html')
    expected = File.read('./test/support/ruby_sample_2.rb.tableized.html')
    #expected_doc = Nokogiri::HTML(expected)
    output = formatter.format(input, 'ruby')
    #output_doc = Nokogiri::HTML(output)

    #assert (expected_doc == output_doc), html_diff(expected_doc, output_doc)
    assert_equal expected, output
  end

  def html_diff(doc_1, doc_2)
    doc_1.diff(doc_2).collect do |change,node|
      if ["+", "-"].include?(change)
        "#{change} #{node.to_html}".ljust(30) + node.parent.path
      end
    end.reject!(&:nil?).join("\n")
  end
end
