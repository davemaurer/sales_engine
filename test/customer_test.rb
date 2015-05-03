require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class CustomerTest < Minitest::Test
  attr_accessor :data

  include TestHelpers
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
    engine = engine_for({
      customers: [{id: 1}, {id: 2}],
      invoices:  [{id: 49, customer_id: 1}, {id: 30, customer_id: 2}]
    })

    customer1 = engine.customer_repository.find_by_id(1)
    customer2 = engine.customer_repository.find_by_id(2)

    assert_equal [49], customer1.invoices.map(&:id)
    assert_equal [30], customer2.invoices.map(&:id)
  end

  def test_successful_transactions
    skip
  end
end
