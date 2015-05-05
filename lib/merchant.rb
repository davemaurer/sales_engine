class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def items
    @repository.find_items_by_id(id)
  end

  def invoices
    @repository.find_invoices_by_id(id)
  end

  def transactions
    invoices.map { |invoice| invoice.transactions }
  end

  def revenue(date = nil)
    if date.nil?
      total_revenue
    else
      revenue_by_date(date)
    end
  end

  def total_revenue
    @total_revenue ||= successful_invoice_items.map { |invoice_item| invoice_item.quantity * invoice_item.unit_price }.reduce(:+)
  end

  def revenue_by_date(date)
    whatever = successful_invoices.select do |invoice|
      Date.parse(invoice.created_at) == date
    end
    x = successful_invoice_items.select do |invoice_item|
      whatever.any? do |invoice|
      invoice.id == invoice_item.invoice_id
      end
    end
    x.map { |invoice_item| invoice_item.quantity * invoice_item.unit_price }.reduce(:+)
  end

  def successful_invoices
    @successful_invoices ||= repository.successful_invoices.select { |invoice| invoice.merchant_id == id }
  end

  def successful_invoice_items
    @successful_invoice_items ||= repository.successful_invoice_items.select do |invoice_item|
      successful_invoices.any? do |invoice|
        invoice.id == invoice_item.invoice_id
      end
    end
  end

  def customers
    successful_invoices.map { |invoice| invoice.customer }
  end

  def favorite_customer
    customers.max_by { |customer| customers.count(customer) }
  end

  def pending_invoices
    invoices - successful_invoices
  end

  def customers_with_pending_invoices
    pending_invoices.flat_map do |invoice|
      repository.find_customers_with_pending_invoices(invoice)
    end
  end
end
