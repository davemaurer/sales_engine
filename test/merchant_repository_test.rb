require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @merchant_repository = engine.merchant_repository
  end

  def test_it_can_find_all_merchants
    assert_equal 5, merchant_repository.all.count
  end

  def test_it_can_find_a_random_merchant
    assert_equal Merchant, merchant_repository.random.class
    a = []
    b = []
    assert_equal a, b
    100.times { a << merchant_repository.random }
    100.times { b << merchant_repository.random }
    refute_equal a, b
  end

  def test_it_can_find_a_merchant_by_id
    assert_equal "Klein, Rempel and Jones", merchant_repository.find_by_id(2).name
  end

  def test_it_can_find_a_merchant_by_name
    assert_equal 2, merchant_repository.find_by_name("Klein, Rempel and Jones").id
  end

  def test_it_can_find_a_merchant_by_created_at_date
    assert_equal "Schroeder-Jerde", merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC").name
  end

  def test_it_can_find_a_merchant_by_updated_at_date
    assert_equal 1, merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_merchants_by_id
    assert_equal 2, merchant_repository.find_all_by_id(4).count
  end

  def test_it_can_find_all_merchants_by_name
    assert_equal 2, merchant_repository.find_all_by_name("Cummings-Thiel").count
  end

  def test_it_can_find_all_merchants_by_created_at_date
    assert_equal 5, merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_merchants_by_updated_at_date
    assert_equal 5, merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end
end
