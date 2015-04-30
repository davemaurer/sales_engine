require_relative 'test_helper'
require_relative '../lib/invoice_item'

class Invoiceinvoice_itemTest < Minitest::Test
  attr_reader :data

  def setup
    @data = { id: 1,
              item_id: 539,
              invoice_id: 1,
              quantity: 5,
              unit_price: 13635,
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC",
            }
  end

  def test_it_has_an_id
    invoice_item = InvoiceItem.new(data, nil)

    assert_equal 1, invoice_item.id
  end

  def test_it_has_an_item_id
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 539, invoice_item.item_id
  end

  def test_it_has_a_invoice_id
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 1, invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 5, invoice_item.quantity
  end

  def test_it_has_a_unit_price
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 13635, invoice_item.unit_price
  end

  def test_it_has_a_created_at_date
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
  end

  def test_it_has_a_updated_at
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

  def test_invoice
    invoice_item = InvoiceItem.new(data, FakeRepo.new)
    assert_equal "found invoice 1", invoice_item.invoice
  end

  def test_item
    invoice_item = InvoiceItem.new(data, FakeRepo.new)
    assert_equal "found item 539", invoice_item.item
  end
end
