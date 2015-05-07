require_relative 'test_helper'
require_relative '../lib/customer.rb'
require_relative '../lib/customer_repository.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/invoice.rb'
require_relative '../lib/invoice_repository.rb'

class IntegrationTest < Minitest::Test
  attr_reader :engine

  def setup
    filepath = File.expand_path "../fixtures", __FILE__
    @engine = SalesEngine.new(filepath)
    engine.startup
  end

  def test_merchant_has_revenue
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal 21067.77, merchant.revenue.to_f
  end

  def merchant_find_dates_by_revenue
    dates_by_revenue = engine.merchant_repository.dates_by_revenue
    assert_instance_of Date, dates_by_revenue[0]
    assert_equal Date.parse("2012-03-25"), dates_by_revenue[0]
    assert_equal Date.parse("2012-03-21"), dates_by_revenue[3]
    refute_includes(dates_by_revenue, Date.parse("2014-03-25"))
  end

  def test_merchant_repository_finds_revenue_for_a_date
    revenue = engine.merchant_repository.revenue(Date.parse("2012-03-25"))
    assert_equal 21067.77, revenue.to_f
  end

  def test_merchant_repository_finds_items_by_merchant_id
    items = engine.merchant_repository.find_all_items_by_merchant_id(1)
    assert_equal "Item Qui Esse", items.first.name
  end

  def test_merchant_repository_returns_most_revenue
    most_revenue = engine.merchant_repository.most_revenue(3)
    assert_equal "Johnston, Gleason and O'Keefe", most_revenue.first.name
  end

  def test_merchant_can_return_items_sold
    merchant = engine.merchant_repository.find_by_id(1)
    items = merchant.items_sold
    assert_equal 47, items
  end

  def test_merchant_has_favorite_customer
    merchant = engine.merchant_repository.find_by_id(1)
    favorite_customer = merchant.favorite_customer
    assert_equal "Joey", favorite_customer.first_name
  end

  def test_merchant_returns_customers_with_pending_invoices
    merchant = engine.merchant_repository.find_by_id(2)
    customers = merchant.customers_with_pending_invoices
    assert_equal "Ramona", customers.first.first_name
  end

  def test_customers_have_transactions
    customer = engine.customer_repository.find_by_id(1)
    transactions = customer.transactions
    assert_equal "success", transactions.first.result
  end

  def test_customers_have_favorite_merchant
    customer = engine.customer_repository.find_by_id(2)
    merchant = customer.favorite_merchant
    assert_equal "Shields, Hirthe and Smith", merchant.name
  end

  def test_item_repository_can_find_invoices
    invoices = engine.item_repository.find_invoices(1)
    assert_equal 11, invoices.first.id
  end

  def test_item_repository_can_find_merchants
    merchants = engine.item_repository.find_merchants(1)
    assert_equal "Schroeder-Jerde", merchants.name
  end

  def test_item_repository_finds_most_items
    items = engine.item_repository.most_items(2)
    assert_equal 1, items.first.id
  end

  def test_item_has_best_day
    item = engine.item_repository.find_by_id(1)
    best_day = item.best_day
    assert_equal Date.parse("2012-03-12"), best_day
  end

  def test_items_have_revenue
    item = engine.item_repository.find_by_id(1)
    revenue = item.revenue
    assert_equal 928.47, revenue.to_f
  end
end
