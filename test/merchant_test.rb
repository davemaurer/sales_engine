require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative 'test_helper'

class MerchantTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id: 1,
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_has_an_id
    merchant = Merchant.new(data, nil)
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new(data, nil)
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_it_has_a_created_at_element
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_an_updated_at_element
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_invoices
    merchant = Merchant.new(data, FakeRepo.new)
    assert_equal "found invoice 1", merchant.invoices
  end

  def test_transactions
    merchant = Merchant.new(data, MerchantRepository.new)
    assert_equal "successful", merchant.transactions
  end
end
