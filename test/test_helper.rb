require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
require_relative '../lib/sales_engine'

module TestHelpers
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
      @customer_repository     = CustomerRepository.new(repo_data.fetch(:customers, []), self)
      @invoice_repository      = InvoiceRepository.new(repo_data.fetch(:invoices, []), self)
      @merchant_repository     = MerchantRepository.new([], self)
      @item_repository         = ItemRepository.new(repo_data.fetch(:items, []), self)
      @invoice_item_repository = InvoiceItemRepository.new(repo_data.fetch(:invoice_items, []), self)
      @transaction_repository  = TransactionRepository.new(repo_data.fetch(:transactions, []), self)
    end
  end

  def engine_for(repo_data)
    engine = SimpleSalesEngine.new(repo_data)
    engine.startup
    engine
  end
end
