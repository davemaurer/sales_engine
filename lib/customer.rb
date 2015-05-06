class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @first_name  = data[:first_name]
    @last_name   = data[:last_name]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end

  def transactions
    @transactions ||= invoices.map do |invoice| invoice.transactions
    end.flatten
  end

  def favorite_merchant
    successful_merchants.max_by do |merchant|
      successful_merchants.count(merchant)
    end
  end

  def successful_transactions
    @successful_transactions ||= transactions.select { |transaction|
      transaction.result == "success"}
  end

  def successful_invoices
    @successful_invoices ||= successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_merchants
    @successful_merchants ||= successful_invoices.map do |invoice|
      invoice.merchant
    end
  end
end
