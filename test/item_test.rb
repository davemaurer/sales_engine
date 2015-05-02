require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_accessor :data

  include TestHelpers

  def setup
    @data = { id: 1,
              name:  "Item Qui Esse",
              description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro",
              unit_price: 75107,
              merchant_id: 1,
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
  end

  def test_it_has_an_id
    item = Item.new(data, nil)

    assert_equal 1, item.id
  end

  def test_it_has_a_name
    item = Item.new(data, nil)
    assert_equal "Item Qui Esse", item.name
  end

  def test_it_has_a_description
    item = Item.new(data, nil)
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new(data, nil)
    assert_equal 1, item.id
  end

  def test_it_has_a_merchant_id
    item = Item.new(data, nil)
    assert_equal 1, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
  end

  def test_it_has_a_updated_at
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_invoice_items
      engine = engine_for({
        items: [{id: 1}, {id: 2}],
        invoice_items:  [{id: 49, item_id: 1}, {id: 30, item_id: 2}]
      })

      item1 = engine.item_repository.find_by_id(1)
      item2 = engine.item_repository.find_by_id(2)

      assert_equal [49], item1.invoice_items.map(&:id)
      assert_equal [30], item2.invoice_items.map(&:id)
    end

  def test_merchant
    engine = engine_for({
      items:         [{id: 1}, {id: 2}],
      merchants:     [{id: 49, item_id: 1}, {id: 30, item_id: 2}]
    })

    merchant1 = engine.item_repository.find_merchant_by_merchant_id(49)
    merchant2 = engine.item_repository.find_merchant_by_merchant_id(30)
    assert_equal 49, merchant1.id
    assert_equal 30, merchant2.id
  end
end
