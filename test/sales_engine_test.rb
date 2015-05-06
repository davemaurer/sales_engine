require_relative "../lib/sales_engine"
require_relative "test_helper"

class SalesEngineTest < Minitest::Test
attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new("./test/fixtures")
    @sales_engine.startup
  end

  def test_it_exists
    assert SalesEngine
  end

  def test_it_can_find_items_by_merchant_id
  items_by_merchant = sales_engine.find_all_items_by_merchant_id(2)

  assert_equal 34, items_by_merchant.count
  end

  def test_it_finds_all_invoices_by_merchant_id
      result = sales_engine.find_all_invoices_by_merchant_id(1)

      assert_equal 2, result.length
      assert_equal "shipped", result.first.status
  end

  def test_it_finds_all_invoices_by_id
      result = sales_engine.find_invoice_by_invoice_id(1)

      assert_equal "shipped", result.status
  end

  def test_it_finds_all_invoices_for_invoice_item_by_id
      result = sales_engine.find_invoice_for_invoice_item(1)

      assert_equal "shipped", result.status
  end

  def test_it_finds_all_items_for_invoice_item
      result = sales_engine.find_all_items_by_item_id(1)

      assert_equal "Item Qui Esse", result.first.name
  end

  def test_it_finds_invoices_by_item_id
    result = sales_engine.find_invoices_by_item_id(539)

    assert_equal 1, result.first.id
  end

  def test_it_finds_transactions_by_invoice_id
    result = sales_engine.find_all_transactions_by_invoice_id(1)

    assert_equal "success", result.first.result
  end

  def test_it_finds_all_invoice_items_by_invoice_id
    result = sales_engine.find_all_invoice_items_by_invoice_id(1)

    assert_equal 539, result.first.item_id
  end

  def test_it_finds_merchant_by_merchant_id
    result = sales_engine.find_merchant_by_merchant_id(1)

    assert_equal "Schroeder-Jerde", result.name
  end

  def test_it_finds_all_customers_by_customer_id
    result = sales_engine.find_all_customers_by_customer_id(1)

    assert_equal "Joey", result.first_name
  end
end
