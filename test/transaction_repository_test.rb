require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @transaction_repository = engine.transaction_repository
  end

  def test_it_can_find_all_transactions
    assert_equal 7, transaction_repository.all.count
  end

  def test_it_can_find_a_random_transaction
    assert_equal Transaction, transaction_repository.random.class
    a = []
    b = []
    assert_equal a, b
    100.times { a << transaction_repository.random }
    100.times { b << transaction_repository.random }
    refute_equal a, b
  end

  def test_it_can_find_a_transaction_by_id
    assert_equal 4, transaction_repository.find_by_id(3).invoice_id
  end

  def test_it_can_find_a_transaction_by_invoice_id
    assert_equal 3, transaction_repository.find_by_invoice_id(4).id
  end

  def test_it_can_find_a_transaction_by_credit_card_number
    assert_equal 2, transaction_repository.find_by_credit_card_number("4580251236515201").id
  end

  def test_it_can_find_a_transaction_by_credit_card_expiration_date
    assert_equal nil, transaction_repository.find_by_credit_card_expiration_date("")
  end

  def test_it_can_find_a_transaction_by_result
    assert_equal 11, transaction_repository.find_by_result("failed").id
  end

  def test_it_can_find_a_transaction_by_created_at_date
    assert_equal 3, transaction_repository.find_by_created_at("2012-03-27 14:54:10 UTC").id
  end

  def test_it_can_find_a_transaction_by_the_updated_at_date
    assert_equal 4, transaction_repository.find_by_updated_at("2012-03-27 14:54:10 UTC").invoice_id
  end

  def test_it_can_find_all_transactions_by_id
    assert_equal 2, transaction_repository.find_all_by_id(4).count
  end

  def test_it_can_find_all_transactions_by_invoice_id
    assert_equal 2, transaction_repository.find_all_by_invoice_id(12).count
  end

  def test_it_can_find_all_transactions_by_credit_card_number
    assert_equal 2, transaction_repository.find_all_by_credit_card_number("4515551623735607").count
  end

  def test_it_can_find_all_transactions_by_credit_card_expiration_date
    assert_equal 0, transaction_repository.find_all_by_credit_card_expiration_date("").count
  end

  def test_it_can_find_all_transactions_by_result
    assert_equal 5, transaction_repository.find_all_by_result("success").count
  end

  def test_it_can_find_all_transactions_by_created_at_date
    assert_equal 5, transaction_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC").count
  end

  def test_it_can_find_all_transactions_by_updated_at_date
    assert_equal 5, transaction_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC").count
  end
end
