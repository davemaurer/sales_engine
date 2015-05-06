require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices,
              :engine

  def initialize(data, engine)
    @engine = engine
    @invoices = data.map {|attributes| Invoice.new(attributes, self) }
  end

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find {|invoice| invoice.id == id}
  end

  def find_all_by_id(id)
    invoices.find_all {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    invoices.find {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    invoices.find {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    invoices.find {|invoice| invoice.status == status}
  end

  def find_all_by_status(status)
    invoices.find_all {|invoice| invoice.status == status}
  end

  def find_by_created_at(created_at)
    invoices.find {|invoice| invoice.created_at == created_at}
  end

  def find_all_by_created_at(created_at)
    invoices.find_all {|invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    invoices.find {|invoice| invoice.updated_at == updated_at}
  end

  def find_all_by_updated_at(updated_at)
    invoices.find_all {|invoice| invoice.updated_at == updated_at}
  end

  def find_all_transactions_by_invoice_id(id)
    engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    engine.find_all_invoice_items_by_invoice_id(id)
  end

  def find_all_items_by_invoice_id(id)
    engine.find_all_items_by_invoice_id(id)
  end

  def find_all_customers_by_customer_id(id)
    engine.find_all_customers_by_customer_id(id)
  end

  def find_all_merchants_by_invoice_id(invoice_id)
    engine.find_all_merchants_by_invoice_id(invoice_id)
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end

  def find_successful_transactions(id)
    engine.find_all_transactions_by_invoice_id(id).select { |trans|
      trans.result == "success" }
  end

  def create(input)
    data = {
      id:          "#{invoices.last.id + 1}",
      customer_id: input[:customer].id,
      merchant_id: input[:merchant].id,
      status:      input[:status],
      created_at:  "#{Date.new}",
      updated_at:  "#{Date.new}",
    }

    new_invoice = Invoice.new(data, self)
    invoices << new_invoice

    invoice_id = data[:id]
    unique_items = input[:items].uniq
    quantities = input[:items].group_by {|item| item}
    unique_items.each do |item|
      quantity = quantities[item].count
      engine.invoice_item_repository
        .create_invoice_items(invoice_id, item, quantity)
      end
    new_invoice
  end

  def create_transaction(card, id)
    engine.transaction_repository.create_transaction(card, id)
  end
end
