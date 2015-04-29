require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class CustomerTest < Minitest::Test
  attr_accessor :data

  def setup
    @data = { id: 1,
              first_name: "Joey",
              last_name:  "Ondricka",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
  end

  def test_it_has_an_id
    customer = Customer.new(data, nil)
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(data, nil)
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(data, nil)
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_a_updated_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_can_find_all_invoices
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    customer_repository = engine.customer_repository
    customer = Customer.new(customer_repository, nil)
    assert_equal Invoice, customer.invoices.class
  end
end
