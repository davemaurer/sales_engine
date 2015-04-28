require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_can_find_all_items
    engine = SalesEngine.new("./data")
    engine.startup
    item = engine.item_repository

    assert_equal 1, item.all
  end
end
