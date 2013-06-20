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
    end
  end
end