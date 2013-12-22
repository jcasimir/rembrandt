require 'minitest/autorun'
require 'minitest/pride'
require './lib/rembrandt/formatters/table'

class FormattersTableTest < Minitest::Test
  def test_it_exists
    assert Rembrandt::Formatters::Table.new
  end
end
