class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def invoices
    @repository.find_all_invoices_by_customer_id(id)
  end


  def transactions
    invoices.map { |invoice| invoice.transactions }
  end

  def favorite_merchant
    successful_invoices = successful_invoices(successful_transactions)

    successful_merchants = successful_merchants(successful_invoices)

    successful_merchants.max_by do |merchant|
      successful_merchants.count(merchant)
    end
  end

  def successful_transactions
    transactions.find do |transaction|
      transaction.successful?
    end

  end

  def successful_invoices(transaction)
    transactions.map do |successful_invoice|
      successful_invoice.invoice
    end
  end

  def successful_merchants(invoices)
    invoices.map { |invoice| invoice.merchant }
  end
end

#favorite_merchant returns an instance of Merchant where the customer has conducted the most successful transactions
