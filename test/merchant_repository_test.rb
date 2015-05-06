require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :data,
              :merchant_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @merchant_repository = engine.merchant_repository
  end

  def test_it_can_access_a_single_merchant
    assert_equal "Schroeder-Jerde", merchant_repository.find_by_id(1).name
  end

  def test_it_loads_all
    assert_equal Array, merchant_repository.all.class
    assert_equal 49, merchant_repository.all.count
    assert_equal Merchant, merchant_repository.all[0].class
  end

  def test_random_can_pick_one_merchant
    assert_equal Merchant, merchant_repository.random.class
    refute_equal Array, merchant_repository.random.class
  end

  def test_it_finds_merchant_by_id
    result = merchant_repository.find_by_id(2)
    assert_equal "Klein, Rempel and Jones", result.name
  end

  def test_it_finds_all_merchants_by_id
    result = merchant_repository.find_all_by_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_name
    result = merchant_repository.find_by_name("Klein, Rempel and Jones")

    assert_equal 2, result.id
  end

  def test_find_all_by_name
    result = merchant_repository.find_all_by_name("Klein, Rempel and Jones")

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_find_by_created_at
    result = merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_created_at
    result = merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal Array, result.class
    assert_equal 9, result.length
  end

  def test_find_by_updated_at
    result = merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal 1, result.id
  end

  def test_find_all_by_updated_at
    result = merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal Array, result.class
    assert_equal 8, result.length
  end
end
