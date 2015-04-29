class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @repository = repository
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def transactions
    transaction_repository.find_transactions_by_invoice_id(id)
  end

  def invoice_items
    transaction_repository.find_invoice_items_by_invoice_id(id)
  end
end



# Invoice
#
# invoice_items returns a collection of associated InvoiceItem instances
# items returns a collection of associated Items by way of InvoiceItem objects
# customer returns an instance of Customer associated with this object
# merchant returns an instance of Merchant associated with this object
