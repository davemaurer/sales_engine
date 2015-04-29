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
    merchant_repository.find_items_by_id(id)
  end

  def invoices
    merchant_repository.find_invoices_by_id(id)
  end

end
