require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :data,
              :invoice_repository,
              :engine

  def setup
    @engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @invoice_repository = engine.invoice_repository
  end

  def test_it_can_access_a_single_item
    assert_equal 1, invoice_repository.invoices[0].id
  end

  def test_it_loads_all
    assert_equal Array, invoice_repository.all.class
    assert_equal 49, invoice_repository.all.count
    assert_equal Invoice, invoice_repository.all[0].class
  end

  def test_random_can_pick_one_item
    assert_equal Invoice, invoice_repository.random.class
    refute_equal Array, invoice_repository.random.class
  end

  def test_it_finds_item_by_id
    result = invoice_repository.find_by_id(1)

    assert_equal 1, result.customer_id
  end

  def test_it_finds_all_items_by_id
    result = invoice_repository.find_all_by_id(3)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_created_at
    result = invoice_repository.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))

    assert_equal 1, result.id
  end

  def test_find_all_by_created_at
    result = invoice_repository.find_all_by_created_at(Date.parse("2012-03-12 05:54:09 UTC"))

    assert_equal Array, result.class
    assert_equal 4, result.length
  end

  def test_find_by_updated_at
    result = invoice_repository.find_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC"))

    assert_equal 1, result.id
  end

  def test_find_all_by_updated_at
    result = invoice_repository.find_all_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC"))

    assert_equal Array, result.class
    assert_equal 2, result.length
  end

  def test_find_by_customer_id
    result = invoice_repository.find_by_customer_id(1)

    assert_equal 1, result.id
  end

  def test_find_all_by_customer_id
    result = invoice_repository.find_all_by_customer_id(1)

    assert_equal Array, result.class
    assert_equal 8, result.length
  end

  def test_find_by_merchant_id
    result = invoice_repository.find_by_merchant_id(1)

    assert_equal 1, result.id
  end

  def test_find_all_by_merchant_id
    result = invoice_repository.find_all_by_merchant_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_status
    result = invoice_repository.find_by_status("shipped")

    assert_equal 1, result.id
  end

  def test_find_all_by_status
    result = invoice_repository.find_all_by_status("shipped")

    assert_equal Array, result.class
    assert_equal 49, result.length
  end

  def test_it_creates_an_invoice
      customer = engine.customer_repository.customers[0]
      merchant = engine.merchant_repository.merchants[0]
      item = engine.item_repository.items[0]
      items = [item, item, item]
      result_1 = invoice_repository.invoices.size
      invoice_repository.create(customer: customer, merchant: merchant, status: "shipped",
                         items: items)
      assert_equal (result_1 + 1), invoice_repository.invoices.size
  end

end
