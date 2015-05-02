require_relative 'test_helper'
require_relative '../lib/invoice_item'

class Invoiceinvoice_itemTest < Minitest::Test
  attr_reader :data

  include TestHelpers

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
    engine = engine_for({
        invoices: [{id: 1}, {id: 2}],
        invoice_items: [
          {id: 30, invoice_id: 1},
          {id: 67, invoice_id: 2}
        ],
      })

    invoice_item1 = engine.invoice_item_repository.find_by_id(30)
    invoice_item2 = engine.invoice_item_repository.find_by_id(67)

    assert_equal 1, invoice_item1.invoice.id
    assert_equal 2, invoice_item2.invoice.id
  end


  def test_item
    engine = engine_for({
      items:         [{id: 1}, {id: 2}],
      invoice_items: [
        {id: 30, item_id: 1},
        {id: 67, item_id: 2}
      ],
    })

    invoice_item1 = engine.invoice_item_repository.find_by_id(30)
    invoice_item2 = engine.invoice_item_repository.find_by_id(67)

    assert_equal 1, invoice_item1.item.id
    assert_equal 2, invoice_item2.item.id
  end
end
