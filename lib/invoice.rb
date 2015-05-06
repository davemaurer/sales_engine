require 'Date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @repository  = repository
  end

  def transactions
    @transactions = repository.find_all_transactions_by_invoice_id(id)
  end

  def invoice_items
    @invoice_items ||= repository.find_all_invoice_items_by_invoice_id(id)
  end

  def items
    @items ||= invoice_items.map { |invoice_item| invoice_item.item }
  end

  def customer
    @customer ||= repository.find_all_customers_by_customer_id(customer_id)
  end

  def merchant
    @merchant ||= repository.find_merchant_by_merchant_id(merchant_id)
  end

  def successful_transactions
    @successful_transactions ||= repository.find_successful_transactions(id)
  end

  def successful_invoices
    @successful_invoices ||= successful_transactions.map { |transaction|
      transaction.invoice }
  end

  def charge(card)
   repository.create_transaction(card, id)
  end

  def paid?
    transactions.any?(&:successful?)
  end

  def total
    @total ||= invoice_items.reduce(0) do |total, invoice_item|
      total + invoice_item.revenue
    end
  end

  def total_quantity
    @total_quantity ||= invoice_items.reduce(0) do |total, invoice_item|
      total + invoice_item.quantity
    end
  end
end
