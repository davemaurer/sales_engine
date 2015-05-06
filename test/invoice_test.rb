require_relative '../lib/invoice'
require_relative 'test_helper'

class InvoiceTest < Minitest::Test

  attr_accessor :data

  def setup
    @data = { id: "1",
              customer_id: "123",
              merchant_id: "456",
              status: "shipped",
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
  end

  def test_it_exists
    assert Invoice
  end

  def test_it_has_an_id
    invoice = Invoice.new(data, nil)
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new(data, nil)
    assert_equal 123, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new(data, nil)
    assert_equal 456, invoice.merchant_id
  end

  def test_it_has_a_status
    invoice = Invoice.new(data, nil)
    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at
    invoice = Invoice.new(data, nil)
    assert_equal "2012-03-27", invoice.created_at.to_s
  end

  def test_it_has_a_updated_at
    invoice = Invoice.new(data, nil)
    assert_equal "2012-03-27", invoice.updated_at.to_s
  end

  def test_items
    invoice = Invoice.new(data.merge(id: 1), FakeInvoiceRepo.new)
    assert_equal ["found item 1"], invoice.items
  end

  def test_customer
    invoice = Invoice.new(data.merge(id: 1), FakeInvoiceRepo.new)
    assert_equal "found customer 123", invoice.customer
  end

  def test_merchant
    invoice = Invoice.new(data.merge(id: 1), FakeInvoiceRepo.new)
    assert_equal "found merchant 456", invoice.merchant
  end

  def test_successful_transactions
    invoice = Invoice.new(data.merge(id: 1), FakeInvoiceRepo.new)
    assert_equal "found 1 successful transaction", invoice.successful_transactions
  end

end

class FakeInvoiceRepo
  def find_all_invoice_items_by_invoice_id(id)
    [FakeInvoiceItem.new(id)]
  end

  def find_all_customers_by_customer_id(customer_id)
    "found customer #{customer_id}"
  end

  def find_merchant_by_merchant_id(merchant_id)
    "found merchant #{merchant_id}"
  end

  def find_successful_transactions(result)
    "found #{result} successful transaction"
  end
end

class FakeInvoiceItem
  def initialize(id)
    @id = id
  end

  def item
    "found item #{@id}"
  end
end
