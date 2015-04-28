require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'parser'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository,

  def initialize(filepath) #we need to take in whatever we parse here
    @filepath = filepath
  end

  def startup     #and pass that into here. Then we send the relevant information down the right chain (ie. merchant = merchant chain)
    customer_data = Parser.parse("#{@filepath}/customers.csv")
    @customer_repository     = CustomerRepository.new(customer_data, self)

    # merchant_repository
    # invoice_repository
    # item_repository
    # invoice_item_repository
    # transaction_repository
  end
end
