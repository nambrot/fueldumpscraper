class BaseRoute < ActiveRecord::Base
  has_many :priced_base_routes
  has_many :priced_strike_routes

  def price_with_strike(search_engine, start_date, end_date, strike, strike_date) 
    price, currency = search_engine.scraper.scrape_round_trip_with_strike(self, strike, start_date, end_date, strike_date)
    self.priced_strike_routes.create :price => price, :currency => currency, :start_date => start_date, :end_date => end_date, :ota => ota, :strike => strike, :strike_date => strike_date
  end

  def price(search_engine, start_date, end_date)
    price, currency = search_engine.scraper.scrape_round_trip(self, start_date, end_date)
    self.priced_base_routes.create :price => price, :currency => currency, :start_date => start_date, :end_date => end_date, :ota => ota
  end

  def to_s
    "#{origin}-#{destination}"
  end

end
