require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants,
              :data

  def initialize(data, engine)
    @engine = engine
    @merchants = data.map { |row| Merchant.new(row, self) }
  end
end
