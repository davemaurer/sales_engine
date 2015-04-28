require_relative '../lib/invoice'
require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :data, :invoice

  def setup
    @data = {
      id: 1,
      customer_id: 1,
      merchant_id: 26,
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC"
    }
    @invoice = Invoice.new(data, nil)
  end

  def test_it_exists
    assert Invoice
  end

  def test_it_has_an_id
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 26, invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at_element
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_an_updated_at_element
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end
end
