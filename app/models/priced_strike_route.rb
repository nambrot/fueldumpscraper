class PricedStrikeRoute < ActiveRecord::Base

  belongs_to :base_route
  belongs_to :strike
  belongs_to :search_engine

  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :strike_date, :presence => true

  validates :search_engine, :associated => true
  validates :search_engine_id, :presence => true
  
  validates :base_route, :associated => true
  validates :base_route_id, :presence => true

  validates :strike, :associated => true
  validates :strike_id, :presence => true

  def price_string
    price.nil? ? "Not priced yet" : "#{price} #{currency}"
  end

  def scrape_price
    delay(:queue => search_engine.identifier).scrape_price_job
    self
  end

  def scrape_price_job
    price, currency = search_engine.scraper.scrape_round_trip_with_strike(base_route, strike, start_date, end_date, strike_date)
    self.price = price
    self.currency = currency
    self.save
  end
end
