require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :data,
              :transaction_repository

  def setup
    engine = SalesEngine.new("./test/fixtures")
    engine.startup
    @transaction_repository = engine.transaction_repository
  end

  def test_it_can_access_a_single_transaction
    assert_equal 1, transaction_repository.transactions[0].id
  end

  def test_it_loads_all
    assert_equal Array, transaction_repository.all.class
    assert_equal 49, transaction_repository.all.count
    assert_equal Transaction, transaction_repository.all[0].class
  end

  def test_random_can_pick_one_transaction
    assert_equal Transaction, transaction_repository.random.class
    refute_equal Array, transaction_repository.random.class
  end

  def test_it_finds_transaction_by_id
    result = transaction_repository.find_by_id(2)

    assert_equal 2, result.invoice_id
  end

  def test_it_finds_all_transactions_by_id
    result = transaction_repository.find_all_by_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.size
  end

  def test_it_finds_transaction_by_invoice_id
    result = transaction_repository.find_by_invoice_id(4)

    assert_equal "4354495077693036", result.credit_card_number
  end

  def test_it_finds_all_transactions_by_invoice_id
    result = transaction_repository.find_all_by_invoice_id(2)

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_it_finds_transaction_by_credit_card_number
    result = transaction_repository.find_by_credit_card_number("4654405418249632")

    assert_equal "2012-03-27 14:54:09 UTC", result.created_at
  end

  def test_it_finds_all_transactions_by_credit_card_number
    result = transaction_repository.find_all_by_credit_card_number("4580251236515201")

    assert_equal Array, result.class
    assert_equal 1, result.length
  end

  def test_it_finds_transaction_by_credit_card_expiration_date
    result = transaction_repository.find_by_credit_card_expiration_date(nil)

    assert_equal 1, result.invoice_id
  end

  def test_it_finds_all_transactions_by_credit_card_expiration_date
    result = transaction_repository.find_all_by_credit_card_expiration_date(nil)

    assert_equal Array, result.class
    assert_equal 49, result.length
  end

  def test_it_finds_transaction_by_result
    result = transaction_repository.find_by_result("failed")

    assert_equal 12, result.invoice_id
  end

  def test_it_finds_all_transactions_by_result
    result = transaction_repository.find_all_by_result("success")

    assert_equal Array, result.class
    assert_equal 40, result.length
  end

  def test_it_finds_transaction_by_date_created
    result = transaction_repository.find_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.updated_at
  end

  def test_it_finds_all_transactions_by_date_created
    result = transaction_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal Array, result.class
    assert_equal 2, result.length
  end

  def test_it_finds_transaction_by_date_updated
    result = transaction_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.created_at
  end

  def test_it_finds_all_transactions_by_date_updated
    result = transaction_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal Array, result.class
    assert_equal 2, result.length
  end

  def test_it_finds_invoice_by_id
    result = transaction_repository.find_invoice(1)

    assert_equal Invoice, result.class
    assert_equal 1, result.id
  end

end
