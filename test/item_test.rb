require_relative '../lib/item'
require_relative 'test_helper'

class ItemTest < Minitest::Test
  attr_accessor :data

  def setup
    @data = { id: "1",
              name: "Item Qui Esse",
              description:  "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
              unit_price: "75107",
              merchant_id: "1",
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
  end

  def test_it_exists
    assert Item
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
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new(data, nil)
    assert "75107", item.unit_price
  end

  def test_it_has_a_merchant_id
    item = Item.new(data, nil)
    assert_equal 1, item.merchant_id
  end

  def test_it_has_a_created_at
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
  end

  def test_it_has_a_updated_at
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_invoice_items
    item = Item.new(data.merge(id: 9), FakeRepo.new)
    assert_equal "found invoice 9", item.invoice_items
  end

  def test_merchant
    item = Item.new(data.merge(merchant_id: 4), FakeRepo.new)
    assert_equal "found merchant 4", item.merchant
  end
end

class FakeRepo
  def find_invoices(id)
    "found invoice #{id}"
  end

  def find_merchants(merchant_id)
    "found merchant #{merchant_id}"
  end
end
