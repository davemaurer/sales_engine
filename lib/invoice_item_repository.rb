require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items,
              :engine

  def initialize (data, engine)
    @engine = engine
    @invoice_items = data.map { |attributes| InvoiceItem.new(attributes, self) }
  end

  def inspect
    "#<#{self.class} #{@invoice_item.size} rows>"
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    invoice_items.find { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    invoice_items.find { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    invoice_items.find { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_by_created_at(created_at)
    invoice_items.find { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoice_items.find { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoice_items.find_all { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item|
      invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all { |invoice_item|
      invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all { |invoice_item|
      invoice_item.unit_price == unit_price }
  end

  def find_all_by_created_at(created_at)
    invoice_items.find_all { |invoice_item|
      invoice_item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.find_all { |invoice_item|
      invoice_item.updated_at == updated_at }
  end

  def find_invoice_by_invoice_id(id)
    @engine.find_invoice_for_invoice_item(id)
  end

  def find_item(item_id)
    @engine.find_item_by_item_id(item_id)
  end

  def find_all_items(id)
    @engine.find_all_items_by_item_id(id)
  end

  def find_invoice(invoice_id)
    @engine.find_invoice_by_invoice_id(invoice_id)
  end

  def create_invoice_items(invoice_id, item, quantity)
    data =  {
            id: "#{invoice_items.last.id + 1}",
            item_id: item.id,
            invoice_id: invoice_id,
            quantity: quantity,
            unit_price: item.unit_price,
            created_at: "#{Date.new}",
            updated_at: "#{Date.new}"
            }
    invoice_items << InvoiceItem.new(data, self)
  end
end
