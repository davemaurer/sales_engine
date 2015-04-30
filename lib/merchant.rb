class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

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

  def revenue(date = nil)
    call invoices, and get invoice_id for each merchant
    if invoice.status is successful, get invoice_item for each invoice_id
    multiply price x quantity
  end

  def transactions
    invoices.map { |invoice| invoice.transactions}
  end

  def successful_transactions
    transactions.find { |transaction| transaction.result == "successful"}
  end
end
