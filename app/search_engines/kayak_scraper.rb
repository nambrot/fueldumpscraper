# coding: utf-8

require 'money/bank/google_currency'

class KayakScraper < Scraper

  def initialize(locale = 'com')
    @locale = locale
  end

  def scrape_round_trip_with_strike(base_route, strike, start_date, end_date, strike_date)
    
    start_date = start_date.try :to_date
    end_date = end_date.try :to_date
    strike_date = strike_date.try :to_date

    Headless.ly do
      browser = Watir::Browser.new :ff
    end
    browser.goto "http://www.kayak.#{@locale}/flights/#{base_route.origin}-#{base_route.destination}/#{start_date.to_s}/#{base_route.destination}-#{base_route.origin}/#{end_date.to_s}/#{strike.origin}-#{strike.destination}/#{strike_date.to_s}"

    # browser.div(:id => "progressDiv").wait_until_present
    browser.div(:id => "progressDiv"  ).wait_while_present(60)
    
    Money.assume_from_symbol = true
    Money.default_bank = Money::Bank::GoogleCurrency.new

    price, number, currency = parse_price browser.element(:css => '.flightresult .results_price').text
    
    browser.quit

    return price.amount, price.currency.iso_code

  end

  def scrape_round_trip(base_route, start_date, end_date)
    
    start_date = start_date.try :to_date
    end_date = end_date.try :to_date

    Headless.ly do
      browser = Watir::Browser.new :ff
    end
    browser.goto "http://www.kayak.#{@locale}/flights/#{base_route.origin}-#{base_route.destination}/#{start_date.to_s}/#{end_date.to_s}"
    # browser.div(:id => "progressDiv").wait_until_present
    browser.div(:id => "progressDiv"  ).wait_while_present(60)
    
    Money.assume_from_symbol = true
    Money.default_bank = Money::Bank::GoogleCurrency.new  
    price, number, currency = parse_price browser.element(:css => '.flightresult .results_price').text
    
    browser.quit

    return price.amount, price.currency.iso_code

  end

end