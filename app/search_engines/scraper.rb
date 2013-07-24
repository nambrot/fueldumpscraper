# encoding: UTF-8
class Scraper
  
  def normalize_currency(currency)
    case currency
    when "€"
      return 'EUR'
    when "\U+FFE2\U+FFAC"
      return 'EUR'
    when '$'
      return 'USD'
    end
  end
  
  def self.scraper(search_engine)
    case search_engine.identifier
    when :kayak
      KayakScraper.new
    when :kayak_es
      KayakScraper.new 'es'
    when :kayak_de
      KayakScraper.new 'de'
    when :matrix
      MatrixScraper.new
    end
  end

  def parse_price(price_string)
    # get currency 
    currency = nil

    case price_string
    when /^\$/ then currency = "USD"
    when /^€/ then currency = "EUR"
    when /^£/ then currency = "GBP"
    when /\$$/ then currency = "USD"
    when /€$/ then currency = "EUR"
    when /£$/ then currency = "GBP"
    when /eur/ then currency = "EUR"
    when /euro/ then currency = "EUR"
    when /Euro/ then currency = "EUR" 
    else
      currency = price_string[/[A-Z]{2,3}/]
    end

    return Money.new(Money.extract_cents(price_string), currency), Money.extract_cents(price_string), currency

  end

end