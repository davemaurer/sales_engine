require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions,
              :engine

  def initialize(data, engine)
    @engine = engine
    @transactions = data.map {|attributes| Transaction.new(attributes, self) }
  end

  def inspect
    "#<#{self.class} #{@transaction.size} rows>"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find {|transaction| transaction.id == id}
  end

  def find_all_by_id(id)
    transactions.find_all {|transaction| transaction.id == id}
  end

  def find_by_invoice_id(invoice_id)
    transactions.find {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find {|transaction|
      transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all {|transaction|
      transaction.credit_card_number == credit_card_number}
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find {|transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find_all {|transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_by_result(result)
    transactions.find {|transaction| transaction.result == result}
  end

  def find_all_by_result(result)
    transactions.find_all {|transaction| transaction.result == result}
  end

  def find_by_created_at(created_at)
    transactions.find {|transaction| transaction.created_at == created_at}
  end

  def find_all_by_created_at(created_at)
    transactions.find_all {|transaction| transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    transactions.find {|transaction| transaction.updated_at == updated_at}
  end

  def find_all_by_updated_at(updated_at)
    transactions.find_all {|transaction| transaction.updated_at == updated_at}
  end

  def find_invoice(id)
    engine.find_invoice_by_invoice_id(id)
  end

  def create_transaction(card, id)
    data = {
          id: "#{transactions.last.id + 1}",
          invoice_id: id,
          credit_card_number: card[:credit_card_number],
          credit_card_expiration_date: card[:credit_card_expiration_date],
          result: card[:result],
          created_at: "#{Date.new}",
          updated_at: "#{Date.new}"
           }

    transaction = Transaction.new(data, self)
    transactions << transaction
  end
end
