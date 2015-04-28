require_relative 'item'

class ItemRepository
  attr_reader :items

  def initialize(data, engine)
    @engine = engine
    @items = data.map { |row| Item.new(row, self) }
  end

  def all
    items
  end
end
