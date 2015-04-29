require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @invoice_repository = engine.invoice_repository
  end

  def test_it_can_find_all_invoices
    assert_equal 5, invoice_repository.all.count
  end

  def test_it_can_find_a_random_invoice
    assert_equal Invoice, invoice_repository.random.class
    a = []
    b = []
    assert_equal a, b
    100.times { a << invoice_repository.random }
    100.times { b << invoice_repository.random }
    refute_equal a, b
  end

  def test_it_can_find_an_invoice_by_id
    assert_equal 26, invoice_repository.find_by_id(1).merchant_id
  end

  def test_it_can_find_an_invoice_by_customer_id
    assert_equal 26, invoice_repository.find_by_customer_id(1).merchant_id
  end

  def test_it_can_find_an_invoice_by_merchant_id
    assert_equal 3, invoice_repository.find_by_merchant_id(78).id
  end

  def test_it_can_find_an_invoice_by_status
    assert_equal 1, invoice_repository.find_by_status("shipped").id
  end

  def test_it_can_find_an_invoice_by_created_at_date
    assert_equal 3, invoice_repository.find_by_created_at("2012-03-10 00:54:09 UTC").id
  end

  def test_it_can_find_an_invoice_by_updated_at_date
    assert_equal 2, invoice_repository.find_by_updated_at("2012-03-12 05:54:09 UTC").id
  end

  def test_it_can_find_all_invoices_by_id
    assert_equal 2, invoice_repository.find_all_by_id(4).count
  end

  def test_it_can_find_all_invoices_by_customer_id
    assert_equal 5, invoice_repository.find_all_by_customer_id(1).count
  end

  def test_it_can_find_all_invoices_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id(33).count
  end

  def test_it_can_find_all_invoices_by_created_at_date
    assert_equal 2, invoice_repository.find_all_by_created_at("2012-03-24 15:54:10 UTC").count
  end

  def test_it_can_find_all_invoices_by_updated_at_date
    assert_equal 2, invoice_repository.find_all_by_updated_at("2012-03-24 15:54:10 UTC").count
  end
end
