<<<<<<< HEAD
require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_accessor :data

  include TestHelpers

  def setup
    @data = {id: 1,
      invoice_id: 1,
      credit_card_number: "4654405418249632",
      credit_card_expiration_date: "",
      result: "success",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC"
    }
=======
require_relative '../lib/transaction'
require_relative 'test_helper'

class TransactionTest < Minitest::Test

  attr_accessor :data

  def setup
    @data = {
              id: "1",
              invoice_id: "1",
              credit_card_number: "4654405418249632",
              credit_card_expiration_date: "x",
              result: "success",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
    end

  def test_it_exists
    assert Transaction
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
  end

  def test_it_has_an_id
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.id
  end

<<<<<<< HEAD
  def test_it_has_a_invoice_id
=======
  def test_it_has_an_invoice_id
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    transaction = Transaction.new(data, nil)
    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    transaction = Transaction.new(data, nil)
<<<<<<< HEAD
    assert_equal "", transaction.credit_card_expiration_date
=======
    assert_equal "x", transaction.credit_card_expiration_date
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
  end

  def test_it_has_a_result
    transaction = Transaction.new(data, nil)
    assert_equal "success", transaction.result
  end

<<<<<<< HEAD
  def test_it_has_a_created_at_date
=======
  def test_it_has_a_created_at
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
  end

  def test_it_has_a_updated_at
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end

<<<<<<< HEAD
  def test_invoice
    engine = engine_for({
        invoices: [{id: 4}, {id: 5}],
        transactions: [
          {id: 3, invoice_id: 4},
          {id: 4, invoice_id: 5}
        ],
      })

    transaction1 = engine.transaction_repository.find_by_id(3)
    transaction2 = engine.transaction_repository.find_by_id(4)

    assert_equal 4, transaction1.invoice.id
    assert_equal 5, transaction2.invoice.id
  end
=======
  def test_it_can_talk_to_the_repository_with_invoice
   parent = Minitest::Mock.new
   transaction = Transaction.new(data, parent)
   parent.expect(:find_invoice, "pizza", [1])

   assert_equal "pizza", transaction.invoice
   parent.verify
 end
>>>>>>> a32ba4c18d7989ef2b45cc26ac4824d1a56d30b6
end
