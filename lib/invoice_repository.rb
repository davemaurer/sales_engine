require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices,
              :engine

  def initialize(data, engine)
    @invoices = data.map { |row| Invoice.new(row, self) }
    @engine = engine
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    invoices.find { |invoice| invoice.status == status }
  end

  def find_by_created_at(created_at)
    invoices.find { |invoice| invoice.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoices.find { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoices.find_all { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.find_all { |invoice| invoice.status == status }
  end

  def find_all_by_created_at(created_at)
    invoices.find_all { |invoice| invoice.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    invoices.find_all { |invoice| invoice.updated_at == updated_at }
  end

  def find_transactions_by_invoice_id(id)
    engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    engine.find_invoice_items_by_invoice_id(id)
  end
end
