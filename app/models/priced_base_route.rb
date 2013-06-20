class PricedBaseRoute < ActiveRecord::Base
  belongs_to :base_route
  belongs_to :search_engine

  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validates :search_engine, :associated => true
  validates :search_engine_id, :presence => true
  
  def price_string
    price.nil? ? "Not priced yet" : "#{price} #{currency}"
  end

  def scrape_price
    delay(:queue => search_engine.identifier).scrape_price_job
    self
  end

  def scrape_price_job
    price, currency = search_engine.scraper.scrape_round_trip(base_route, start_date, end_date)
    self.price = price
    self.currency = currency
    self.save
  end
  
end
