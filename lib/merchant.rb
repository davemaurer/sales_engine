require 'date'

class Merchant
attr_reader :id,
            :name,
            :created_at,
            :updated_at,
            :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def items
    @items ||= @repository.find_all_items_by_merchant_id(id)
  end

  def invoices
    @invoices ||= @repository.find_all_invoices_by_merchant_id(id)
  end

  def transactions
    @transactions ||= invoices.map do |invoice| invoice.transactions
    end.flatten
  end

  def items_sold
    invoices.map do |invoice|
      invoice.successful_invoices
    end.flatten.map do |invoice|
      invoice.invoice_items
    end.flatten.map do |invoice_item|
      invoice_item.quantity.to_i
    end.reduce(:+)
  end

  def successful_customers
    @successful_customers = successful_invoices.map do |invoice|
      invoice.customer
    end
  end

  def favorite_customer
    successful_customers.max_by { |customer|
      successful_customers.count(customer) }
  end

  def unsuccessful_invoices
    invoices.reject do |invoice|
      invoice.transactions.any? do |transaction|
        transaction.successful?
      end
    end.flatten
  end

  def customers_with_pending_invoices
    unsuccessful_invoices.map do |invoice|
      invoice.customer
    end
  end

  def revenue(date=nil)
     if date
      if date.is_a?(Date)
        total = total_from_daily(date)
      end
    else
      total = total_from_all_time
    end
    total
  end

  private

  def successful_transactions
    @successful_transactions ||= transactions.select do |transaction|
      transaction.result == "success"
    end
  end

  def all_successful_invoices
    @all_successful_invoices ||= successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_invoice_items(successful_invoices)
    successful_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def revenue_for_each_item(invoice_items)
    invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
  end

  def successful_invoices(date=nil)
    if date
      all_successful_invoices.select do |success_invoice|
        success_invoice.created_at == date
      end
    else
      all_successful_invoices
    end
  end

  def total_from_daily(date)
    successful_invoices =  successful_invoices(date)
    invoice_items = successful_invoice_items(successful_invoices)
    revenue_for_each_item(invoice_items).reduce(0, :+)
  end

  def total_from_all_time
    successful_invoices.reduce(0) { |total, invoice| total + invoice.total }
  end
end
