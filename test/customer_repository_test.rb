require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    engine = SalesEngine.new("./data")
    engine.startup
    @customer_repository = engine.customer_repository
  end

  def test_it_can_find_all_customers
    assert_equal 1000, customer_repository.all.count
  end

  def test_it_can_find_a_random_customer
    assert_equal Customer, customer_repository.random.class
    a = []
    b = []
    100.times { a << customer_repository.random }
    100.times { b << customer_repository.random }
    refute_equal a, b
  end

  def test_it_can_find_a_customer_by_id
    assert_equal "Toy", customer_repository.find_by_id(3).last_name
  end

  def test_it_can_find_a_customer_by_first_name
    assert_equal 3, customer_repository.find_by_first_name("Mariah").id
  end

  def test_it_can_find_a_customer_by_last_name
    assert_equal "Mariah", customer_repository.find_by_last_name("Toy").first_name
  end

  def test_it_can_find_a_customer_by_the_created_at_date
    assert_equal "Cecelia", customer_repository.find_by_created_at("2012-03-27 14:54:10 UTC").first_name
  end

  def test_it_can_find_a_customer_by_the_updated_at_date
    assert_equal "Osinski", customer_repository.find_by_updated_at("2012-03-27 14:54:10 UTC").last_name
  end

  def test_it_can_find_all_customers_by_id
    assert_equal 1, customer_repository.find_all_by_id(3).count
  end

  def test_it_can_find_all_customers_by_first_name
    assert_equal 1, customer_repository.find_all_by_first_name("Mariah").count
  end

  def test_it_can_find_all_customers_by_last_name
    assert_equal 1, customer_repository.find_all_by_last_name("Smith").count
  end

  def test_it_can_find_all_customers_by_created_at_date
    assert_equal 6, customer_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC").count
  end

  def test_it_can_find_all_customers_by_updated_at_date
    assert_equal 6, customer_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC").count
  end
end
