require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require_relative 'test_helper'

class CustomerTest < Minitest::Test
  attr_accessor :data

  def setup
    @data = { id: 1,
              first_name: "Joey",
              last_name:  "Ondricka",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
  end

  def test_it_has_an_id
    customer = Customer.new(data, nil)
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(data, nil)
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(data, nil)
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_a_updated_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  class SimpleSalesEngine < SalesEngine
    attr_reader :customer_repository,
                :invoice_repository,
                :merchant_repository,
                :item_repository,
                :invoice_item_repository,
                :transaction_repository,
                :repo_data

    def initialize(repo_data)
      @repo_data = repo_data
    end

    def startup
      @customer_repository     = CustomerRepository.new(repo_data[:customers], self)
      @invoice_repository      = InvoiceRepository.new(repo_data[:invoices], self)
      @merchant_repository     = MerchantRepository.new([], self)
      @item_repository         = ItemRepository.new([], self)
      @invoice_item_repository = InvoiceItemRepository.new([], self)
      @transaction_repository  = TransactionRepository.new([], self)
    end
  end

  def engine_for(repo_data)
    engine = SimpleSalesEngine.new(repo_data)
    engine.startup
    engine
  end

  def test_it_can_find_all_invoices
    engine = engine_for({
      customers: [{id: 1}],
      invoices:  [{id: 49, customer_id: 1}, {id: 30, customer_id: 2}]
    })
    customer = engine.customer_repository.find_by_id(1)
    assert_equal [49], customer.invoices.map { |invoice| invoice.id }
  end
end
