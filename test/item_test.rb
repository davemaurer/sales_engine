require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_accessor :data

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
    assert_equal 75107, item.unit_price
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
    item = Item.new(data, FakeRepo.new)
    assert_equal "found 1 items", item.invoice_items
  end

  def test_merchant
    item = Item.new(data, FakeRepo.new)
    assert_equal "found 1 merchant", item.merchant
  end
end
