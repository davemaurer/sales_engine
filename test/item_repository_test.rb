require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @item_repository = engine.item_repository
  end

  def test_it_loads_all_items
  assert_equal 5, item_repository.all.count
  end

  def test_it_finds_a_random_item
    assert_equal Item, item_repository.random.class
  end

  def test_it_finds_an_item_by_id
    assert_equal "Item Qui Esse", item_repository.find_by_id(1).name
  end

  def test_it_finds_an_item_by_name
    assert_equal 1, item_repository.find_by_name("Item Qui Esse").id
  end

  def test_it_finds_an_item_by_description
    assert_equal "Item Qui Esse", item_repository.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.").name
  end

  def test_it_finds_an_item_by_unit_price
    skip
    assert_equal 1, item_repository.find_by_unit_price(75107).id
  end

  def test_it_finds_an_item_by_merchant_id
    assert_equal "Item Qui Esse", item_repository.find_by_merchant_id(1).name
  end

  def test_it_finds_an_item_by_date_created
    assert_equal 1, item_repository.find_by_created_at("2012-03-27 14:53:59 UTC").merchant_id
  end

  def test_it_finds_an_item_by_date_updated
    assert_equal 75107, item_repository.find_by_updated_at("2012-03-27 14:53:59 UTC").unit_price
  end

  def test_it_can_find_all_items_by_id
    assert_equal 1, item_repository.find_all_by_id(3).count
  end

  def test_it_can_find_all_items_by_name
    assert_equal 1, item_repository.find_all_by_name("Item Qui Esse").count
  end

  def test_it_can_find_all_items_by_description
    assert_equal 1, item_repository.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.").count
  end

  def test_it_can_find_all_items_by_unit_price
    skip
    assert_equal 1, item_repository.find_all_by_unit_price(75107).count
  end

  def test_it_can_find_all_items_by_merchant_id
    assert_equal 5, item_repository.find_all_by_merchant_id(1).count
  end

  def test_it_can_find_all_items_by_created_at_date
    assert_equal 5, item_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_items_by_updated_at_date
    assert_equal 5, item_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

  def test_find_all_invoice_items_by_item_id
    assert_equal 1, item_repository.find_all_invoice_items_by_item_id(539).count
  end

  def test_find_merchant_by_merchant_id
    assert_equal "Klein, Rempel and Jones", item_repository.find_merchant_by_merchant_id(2).name
  end
end
