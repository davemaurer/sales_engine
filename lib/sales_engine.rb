require_relative 'parser'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :customer_repository,
              :invoice_item_repository,
              :invoice_repository,
              :item_repository,
              :merchant_repository,
              :transaction_repository

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    customer_data            = Parser.parse("#{@filepath}/customers.csv")
    @customer_repository     = CustomerRepository.new(customer_data, self)
    invoice_item_data        = Parser.parse("#{@filepath}/invoice_items.csv")
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)
    invoice_data             = Parser.parse("#{@filepath}/invoices.csv")
    @invoice_repository      = InvoiceRepository.new(invoice_data,self)
    item_data                = Parser.parse("#{@filepath}/items.csv")
    @item_repository         = ItemRepository.new(item_data, self)
    merchant_data            = Parser.parse("#{@filepath}/merchants.csv")
    @merchant_repository     = MerchantRepository.new(merchant_data, self)
    transaction_data         = Parser.parse("#{@filepath}/transactions.csv")
    @transaction_repository  = TransactionRepository.new(transaction_data, self)
  end

  def find_all_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_invoice_for_invoice_item(id)
    invoice_repository.find_by_id(id)
  end

  def find_item_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_all_items_by_item_id(id)
    item_repository.find_all_by_id(id)
  end

  def find_invoices_by_item_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_all_customers_by_customer_id(id)
    customer_repository.find_by_id(id)
  end
end
