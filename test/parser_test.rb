require_relative '../lib/parser'
require_relative 'test_helper'


class ParserTest < Minitest::Test
  def test_it_parses_data
    filepath = "./test/fixtures/merchants.csv"
    data = Parser.parse(filepath)
    assert_equal data.path, "./test/fixtures/merchants.csv"
  end
end
