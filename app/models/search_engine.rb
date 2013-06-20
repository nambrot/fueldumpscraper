class SearchEngine < ActiveRecord::Base

  def identifier
      value = read_attribute('identifier')
      value.blank? ? nil : value.to_sym
  end

  def scraper
    case identifier
    when :kayak
      KayakScraper.new
    when :kayak_es
      KayakScraper.new 'es'
    when :kayak_de
      KayakScraper.new 'de'
    end
  end
end
