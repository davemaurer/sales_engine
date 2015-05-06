require_relative '../lib/customer'
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

  def test_it_exists
    assert Customer
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

  def test_invoices
    customer = Customer.new(data.merge(id: 2), FakeRepo.new)
    assert_equal "found invoice 2", customer.invoices
  end
end

class FakeRepo
  def find_invoices(id)
    "found invoice #{id}"
  end
end
