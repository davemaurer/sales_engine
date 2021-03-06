require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price])/100
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def invoice_items
    @invoice_items ||= repository.find_invoices(id)
  end

  def merchant
    @merchant ||= repository.find_merchants(merchant_id)
  end

  def best_day
    maximum_item = invoice_items.max_by { |invoice_item| invoice_item.quantity }
    maximum_item.invoice.created_at
  end

  def revenue
    successful_invoice_items ||= invoice_items.select { |invoice_item|
      invoice_item.successful? }

    successful_invoice_items.reduce(0) { |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity) }
  end

  def quantity_sold
    successful_invoice_items ||= invoice_items.select { |invoice_item|
      invoice_item.successful? }

    successful_invoice_items.reduce(0) { |sum, invoice_item|
      sum + invoice_item.quantity }
   end

  private

  def invoice_item_repository
    repository.engine.invoice_item_repository
  end
end
