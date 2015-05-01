require_relative 'customer'

class CustomerRepository
  attr_reader :customers,
              :engine
  def initialize(data, engine)
    @engine = engine
    @customers  = data.map { |attributes| Customer.new(attributes, self) }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    customers.find { |customer| customer.first_name == first_name }
  end

  def find_by_last_name(last_name)
    customers.find { |customer| customer.last_name == last_name }
  end

  def find_by_created_at(created_at)
    customers.find { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    customers.find { |customer| customer.updated_at == updated_at }
  end

  def find_all_by_id(id)
    customers.find_all { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.find_all { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    customers.find_all { |customer| customer.last_name == last_name }
  end

  def find_all_by_created_at(created_at)
    customers.find_all { |customer| customer.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    customers.find_all { |customer| customer.updated_at == updated_at }
  end

  def find_all_invoices_by_customer_id(id)
    engine.find_all_invoices_by_customer_id(id)
  end
end
