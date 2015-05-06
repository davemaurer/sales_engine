require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :data,
              :item_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @item_repository = engine.item_repository
  end

  def test_it_can_access_a_single_item
    assert_equal "Item Qui Esse", item_repository.items[0].name
  end

  def test_it_loads_all
    assert_equal Array, item_repository.all.class
    assert_equal 49, item_repository.all.count
    assert_equal Item, item_repository.all[0].class
  end

  def test_random_can_pick_one_item
    assert_equal Item, item_repository.random.class
    refute_equal Array, item_repository.random.class
  end

  def test_it_finds_item_by_id
    result = item_repository.find_by_id(1)

    assert_equal "Item Qui Esse", result.name
  end

  def test_it_finds_all_items_by_id
    result = item_repository.find_all_by_id(3)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_created_at
    result = item_repository.find_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_created_at
    result = item_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal Array, result.class
    assert_equal 49, result.length
  end

  def test_find_by_updated_at
    result = item_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_updated_at
    result = item_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal Array, result.class
    assert_equal 49, result.length
  end

  def test_find_by_name
    result = item_repository.find_by_name("Item Qui Esse")

    assert_equal 1, result.id
  end

  def test_find_all_by_name
    result = item_repository.find_all_by_name("Item Ea Voluptatum")

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_description
    result = item_repository.find_by_description("Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.")

    assert_equal 3, result.id
  end

  def test_find_all_by_description
    result = item_repository.find_all_by_description("Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.")

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_unit_price
    result = item_repository.find_by_unit_price(323.01)

    assert_equal 3, result.id
  end

  def test_find_all_by_unit_price
    result = item_repository.find_all_by_unit_price(323.01)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_merchant_id
    result = item_repository.find_by_merchant_id(1)

    assert_equal 1, result.id
  end

  def test_find_all_by_merchant_id
    result = item_repository.find_all_by_merchant_id(1)

    assert_equal Array, result.class
    assert_equal 15, result.length
  end
end
