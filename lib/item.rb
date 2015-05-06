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
    selected_invoices ||= invoice_items.map { |invoice_item|
      invoice_item.invoice }

    selected_invoices.uniq!

    selected_transactions ||= selected_invoices.map { |invoice|
      invoice.transactions }.flatten

    successful_transactions ||= selected_transactions.select { |transaction|
      transaction.result == "success" }

    successful_invoices ||= successful_transactions.map { |transaction|
      transaction.invoice }

    successful_invoice_items ||= successful_invoices.map { |invoice|
      invoice.invoice_items }.flatten

    invoice_items_for_item ||= successful_invoice_items.select { |invoice_item|
      invoice_item.item_id == id }

    item_revenue = invoice_items_for_item.map { |invoice_item|
      invoice_item.unit_price * invoice_item.quantity }

    item_revenue.flatten.reduce(0, :+)
  end

  def quantity_sold
     selected_invoices ||= invoice_items.map { |invoice_item|
       invoice_item.nil? ? [] : invoice_item.invoice }

     selected_invoices.uniq!

     selected_transactions ||= selected_invoices.map { |invoice|
       invoice.transactions }.flatten

     successful_transactions ||= selected_transactions.select { |transaction|
       transaction.result == "success" }

     successful_invoices ||= successful_transactions.map { |transaction|
       transaction.invoice }.uniq

     successful_invoice_items ||= successful_invoices.map { |invoice|
       invoice.invoice_items }.flatten

     invoice_items_for_item ||= successful_invoice_items.select { |invoice_item|
       invoice_item.item_id == id }

     invoice_items_for_item.flatten.map { |invoice_item|
       invoice_item.quantity }.reduce(:+)
   end

  private

  def invoice_item_repository
    repository.engine.invoice_item_repository
  end
end
