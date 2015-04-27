require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'parser'
require_relative 'transaction_repository'

class SalesEngine
  def initialize() #we need to take in whatever we parse here

  end

  def startup     #and pass that into here. Then we send the relevant information down the right chain (ie. merchant = merchant chain)
    engine.merchant_repository
    engine.invoice_repository
    engine.item_repository
    engine.invoice_item_repository
    engine.customer_repository
    engine.transaction_repository
  end
end
