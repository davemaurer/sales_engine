require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :data,
              :invoice_item_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @invoice_item_repository = engine.invoice_item_repository
  end

  def test_it_can_access_a_single_invoice_item
    assert_equal 528, invoice_item_repository.invoice_items[1].item_id
  end

  def test_it_loads_all
    assert_equal Array, invoice_item_repository.all.class
    assert_equal 49, invoice_item_repository.all.count
    assert_equal InvoiceItem, invoice_item_repository.all[0].class
  end

  def test_random_can_pick_one_invoice_item
    assert_equal InvoiceItem, invoice_item_repository.random.class
    refute_equal Array, invoice_item_repository.random.class
  end

  def test_it_finds_invoice_item_by_id
    result = invoice_item_repository.find_by_id(2)

    assert_equal 528, result.item_id
  end

  def test_it_finds_all_invoice_items_by_id
    result = invoice_item_repository.find_all_by_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.size
  end

  def test_it_finds_invoice_item_by_item_id
    result = invoice_item_repository.find_by_item_id(528)

    assert_equal 2, result.id
  end

  def test_it_finds_all_invoice_items_by_item_id
    result = invoice_item_repository.find_all_by_item_id(528)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_it_finds_invoice_item_by_invoice_id
    result = invoice_item_repository.find_by_invoice_id(1)

    assert_equal "2012-03-27 14:54:09 UTC", result.created_at
  end

  def test_it_finds_all_invoice_items_by_invoice_id
    result = invoice_item_repository.find_all_by_invoice_id(1)

    assert_equal Array, result.class
    assert_equal 8, result.length
  end

  def test_it_finds_invoice_item_by_quantity
    result = invoice_item_repository.find_by_quantity(9)

    assert_equal 1, result.invoice_id
  end

  def test_it_finds_all_invoice_items_by_quantity
    result = invoice_item_repository.find_all_by_quantity(9)

    assert_equal Array, result.class
    assert_equal 7, result.length
  end

  def test_it_finds_invoice_item_by_unit_price
    result = invoice_item_repository.find_by_unit_price(BigDecimal.new("13635")/100)

    assert_equal 5, result.quantity
  end

  def test_it_finds_all_invoice_items_by_unit_price
    result = invoice_item_repository.find_all_by_unit_price(BigDecimal.new("13635")/100)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_it_finds_invoice_item_by_date_created
    result = invoice_item_repository.find_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.updated_at
  end

  def test_it_finds_all_invoice_items_by_date_created
    result = invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal Array, result.class
    assert_equal 15, result.length
  end

  def test_it_finds_invoice_item_by_date_updated
    result = invoice_item_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.created_at
  end

  def test_it_finds_all_invoice_items_by_date_updated
    result = invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal Array, result.class
    assert_equal 15, result.length
  end

  def test_it_can_access_sales_engine_by_item_id
    result = invoice_item_repository.find_invoice_by_invoice_id(1)

    assert_equal 1, result.customer_id
  end

  def test_it_can_access_sales_engine_for_item
    result = invoice_item_repository.find_item(1)

    assert_equal "Item Qui Esse", result.name
  end

  def test_it_can_access_sales_engine_for_items
    result = invoice_item_repository.find_all_items(1)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_it_can_access_sales_engine_for_invoice_id
    result = invoice_item_repository.find_invoice(1)

    assert_equal 1, result.merchant_id
  end

end
