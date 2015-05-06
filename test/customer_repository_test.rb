require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :data,
              :customer_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @customer_repository = engine.customer_repository
  end

  def test_it_can_access_a_single_customer
    assert_equal "Cecelia", customer_repository.find_by_id(2).first_name
  end

  def test_it_loads_all
    assert_equal Array, customer_repository.all.class
    assert_equal 49, customer_repository.all.count
    assert_equal Customer, customer_repository.all[0].class
  end

  def test_random_can_pick_one_customer
    assert_equal Customer, customer_repository.random.class
    refute_equal Array, customer_repository.random.class
  end

  def test_it_finds_customer_by_id
    result = customer_repository.find_by_id(3)

    assert_equal "Mariah", result.first_name
  end

  def test_it_finds_all_customers_by_id
    result = customer_repository.find_all_by_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_first_name
    result = customer_repository.find_by_first_name("Mariah")

    assert_equal 3, result.id
  end

  def test_find_all_by_first_name
    result = customer_repository.find_all_by_first_name("Cecelia")

    assert_equal Array, result.class
    assert_equal 1, result.length
  end


    def test_find_by_last_name
      result = customer_repository.find_by_last_name("Osinski")

      assert_equal 2, result.id
    end

    def test_find_all_by_last_name
      result = customer_repository.find_all_by_last_name("Osinski")

      assert_equal Array, result.class
      assert_equal 1, result.length
    end

  def test_find_by_created_at
    result = customer_repository.find_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_created_at
    result = customer_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal Array, result.class
    assert_equal 6, result.length
  end

  def test_find_by_updated_at
    result = customer_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_updated_at
    result = customer_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal Array, result.class
    assert_equal 6, result.length
  end

  def test_it_finds_invoice_by_id
    result = customer_repository.find_invoices(1)

    assert_equal Array, result.class
    assert_equal 8, result.length
  end

end
