require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'parser'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :customer_repository,
              :invoice_repository
              :merchant_repository,
              :item_repository,
              :invoice_item_repository,
              :transaction_repository

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    customer_data            = Parser.parse("#{@filepath}/customers.csv")
    @customer_repository     = CustomerRepository.new(customer_data, self)

    invoice_data             = Parser.parse("#{@filepath}/invoices.csv")
    @invoice_repository      = InvoiceRepository.new(invoice_data, self)

    merchant_data            = Parser.parse("#{@filepath}/merchants.csv")
    @merchant_repository     = MerchantRepository.new(merchant_data, self)

    item_data                = Parser.parse("#{@filepath}/items.csv")
    @item_repository         = ItemRepository.new(item_data, self)

    invoice_item_data        = Parser.parse("#{@filepath}/invoice_items.csv")
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)

    transaction_data         = Parser.parse("#{@filepath}/transactions.csv")
    @transaction_repository  = TransactionRepository.new(transactions_data, self)
  end

  def invoice_by_id(id)
    invoice_repository.find_by_customer_id(id).invoice_id
  end
end
