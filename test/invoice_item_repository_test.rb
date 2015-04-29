require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @invoice_item_repository = engine.invoice_item_repository
  end

  def test_it_can_load_all_invoice_items
    assert_equal 5, invoice_item_repository.all.count
  end

  def test_it_can_find_a_random_invoice_item
    assert_equal InvoiceItem, invoice_item_repository.random.class
    a = []
    b = []
    assert_equal a, b
    100.times { a << invoice_item_repository.random }
    100.times { b << invoice_item_repository.random }
    refute_equal a, b
  end

  def test_it_can_find_a_invoice_item_by_id
    assert_equal 1, invoice_item_repository.find_by_id(1).invoice_id
  end

  def test_it_can_find_a_invoice_item_by_item_id
    assert_equal 1, invoice_item_repository.find_by_item_id(539).invoice_id
  end

  def test_it_can_find_a_invoice_item_by_invoice_id
    assert_equal 539, invoice_item_repository.find_by_invoice_id(1).item_id
  end

  def test_it_can_find_a_invoice_item_by_quantity
    assert_equal 13635, invoice_item_repository.find_by_quantity(5).unit_price
  end

  def test_it_can_find_a_invoice_item_by_unit_price
    assert_equal 5, invoice_item_repository.find_by_unit_price(13635).quantity
  end

  def test_it_can_find_a_invoice_item_by_the_created_at_date
    assert_equal 1, invoice_item_repository.find_by_created_at("2012-03-27 14:54:09 UTC").id
  end

  def test_it_can_find_a_invoice_item_by_the_updated_at_date
    assert_equal 539, invoice_item_repository.find_by_updated_at("2012-03-27 14:54:09 UTC").item_id
  end

  def test_it_can_find_all_invoice_items_by_id
    assert_equal 2, invoice_item_repository.find_all_by_id(4).count
  end

  def test_it_can_find_all_invoice_items_by_item_id
    assert_equal 2, invoice_item_repository.find_all_by_item_id(535).count
  end

  def test_it_can_find_all_invoice_items_by_invoice_id
    assert_equal 5, invoice_item_repository.find_all_by_invoice_id(1).count
  end

  def test_it_can_find_all_invoice_items_by_created_at_date
    assert_equal 5, invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_can_find_all_invoice_items_by_updated_at_date
    assert_equal 5, invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end
end
