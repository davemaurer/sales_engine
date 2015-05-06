require_relative '../lib/invoice_item'
require_relative 'test_helper'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  attr_accessor :data

  def setup
    @data = {
              id: 1,
              item_id: 539,
              invoice_id: 1,
              quantity: 5,
              unit_price: "13635",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
  end



  def test_it_exists
    assert InvoiceItem
  end

  def test_it_has_an_id
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 1, invoice_item.id
  end

  def test_it_has_an_item_id
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 539, invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 1, invoice_item.invoice_id
  end

  def test_it_has_quantity
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 5, invoice_item.quantity
  end

  def test_it_has_unit_price
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 136, invoice_item.unit_price.to_i
  end

  def test_it_has_created_at
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
  end

  def test_it_has_updated_at
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

<<<<<<< HEAD
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

=======
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
  def test_item
    invoice_item = InvoiceItem.new(data.merge(id: 1), FakeInvoiceItemRepo.new)

    assert_equal "539", invoice_item.item
  end
end

class FakeInvoiceItemRepo
  def find_item(item_id)
    "#{item_id}"
  end
end
