require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants,
              :engine

  def initialize(data, engine)
    @merchants = data.map { |row| Merchant.new(row, self) }
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_id(id)
    merchants.find_all { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name == name }
  end

  def find_all_by_created_at(created_at)
    merchants.find_all { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.find_all { |merchant| merchant.updated_at == updated_at }
  end

  def find_invoices_by_merchant_id(id)
    engine.invoice_by_merchant_id(id)
  end

  def find_items_by_id(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_id(id)
    engine.find_invoices_by_merchant_id(id)
  end

  def successful_invoices
    engine.successful_invoices
  end

  def successful_invoice_items
    engine.successful_invoice_items
  end

  def find_customers_with_pending_invoices(invoice)
    engine.find_customers_with_pending_invoices(invoice)
  end

  def revenue(date)
    merchants.reduce(0) do |sum, merchant|
      sum + merchant.revenue(date)
    end.flatten
  end
end
