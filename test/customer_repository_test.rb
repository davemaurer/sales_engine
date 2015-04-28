require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_can_access_a_single_customer
    se = SalesEngine.new("./lib/data")
    assert_equal "Cecelia", customer_repository.find_by_id(2).first_name
  end

  def test_it_loads_all
    skip
    assert_equal Array, customer_repository.all.class
    assert_equal 49, customer_repository.all.count
    assert_equal Customer, customer_repository.all[0].class
  end

  def test_random_can_pick_one_customer
    skip
    assert_equal Customer, customer_repository.random.class
    refute_equal Array, customer_repository.random.class
  end

  def test_it_finds_customer_by_id
    skip
    result = customer_repository.find_by_id(3)

    assert_equal "Mariah", result.first_name
  end
end
