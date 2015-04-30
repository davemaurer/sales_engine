require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
# require_relative '../lib/sales_engine'

class FakeRepo
  def find_invoices_by_id(id)
    "found invoice #{id}"
  end

  def find_invoice_by_invoice_id(invoice_id)
    "found invoice #{invoice_id}"
  end

  def find_item_by_item_id(item_id)
    "found item #{item_id}"
  end

  def find_all_invoice_items_by_item_id(id)
    "found #{id} items"
  end

  def find_merchant_by_merchant_id(merchant_id)
    "found #{merchant_id} merchant"
  end
end

#
# class SimpleSalesEngine < SalesEngine
#   attr_reader :customer_repository,
#               :invoice_repository,
#               :merchant_repository,
#               :item_repository,
#               :invoice_item_repository,
#               :transaction_repository,
#               :repo_data
#
#   def initialize(repo_data)
#     @repo_data = repo_data
#   end
#
#   def startup
#     @customer_repository     = CustomerRepository.new(repo_data[:customers], self)
#     @invoice_repository      = InvoiceRepository.new(repo_data[:invoices], self)
#     @merchant_repository     = MerchantRepository.new([], self)
#     @item_repository         = ItemRepository.new([], self)
#     @invoice_item_repository = InvoiceItemRepository.new([], self)
#     @transaction_repository  = TransactionRepository.new([], self)
#   end
# end
