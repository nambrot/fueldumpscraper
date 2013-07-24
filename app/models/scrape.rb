class Scrape < ActiveRecord::Base

  serialize :base_route_ids, Array
  serialize :strike_ids, Array
  serialize :search_engine_ids, Array

  # validate
  validate :validate_date_string_format
  validate :validate_base_route_ids
  validate :validate_strike_ids
  validate :validate_search_engine_ids
  
  attr_accessor :base_routes
  attr_accessor :strikes
  attr_accessor :search_engines

  def date_string_format_valid?(date_string)
    # Valid: ((2013-03-01, 2013-03-5, 2013-04-5), (+1, +1, +1), (-1, -2, -1)) + 7 * 3, meaning (2013-03-01, 2013-03-5, 2013-04-5), (2013-03-02, 2013-03-6, 2013-04-6), (2013-02-28, 2013-03-4, 2013-04-4), repeated for the next 3 weeks
    # Maximum date variations 50 right now
    begin
      valid = true

      parsed_date_string = date_string.match /\A\s*\((.*)\)\s*\+\s*(\d*)\s*\*\s*(\d*)/
      
      # check dates
      begin
        parsed_date_string[1].match(/\((.*?)\)/)[1].split(',').map { |date| Date.parse date.strip }
      rescue Exception => e
        valid &&= false
      end
      
      # check following pairs
      parsed_date_string[1].scan(/\((.*?)\)/).drop(1).each do |pair|
        valid &&= false if pair.first.split(',').map { |el| el.strip.match(/\A[\+\-]\d\z/) }.any?(&:blank?)
      end

      # check accumulate number
      # (datepair + number of pairs) * multiplier
      valid &&= false if parsed_date_string[1].scan(/\((.*?)\)/).length * parsed_date_string.captures.last.to_i > 50

    rescue Exception => e
      return false
    end

    return valid
  end

  def validate_date_string_format
    errors.add(:date_string, "is malformatted") unless date_string_format_valid?(date_string)
  end

  def validate_base_route_ids
    errors.add(:base_route_ids, "is empty") if base_route_ids.empty?
    begin
      self.base_routes = BaseRoute.find base_route_ids
    rescue Exception => e
      errors.add(:base_route_ids, "some base routes could not be found")
    end
  end

  def validate_strike_ids
    begin
      self.strikes = Strike.find strike_ids
    rescue Exception => e
      errors.add(:strike_ids, "some strikes could not be found")
    end
  end

  def validate_search_engine_ids
    errors.add(:search_engine_ids, "is empty") if search_engine_ids.empty?
    begin
      self.search_engines = SearchEngine.find search_engine_ids
    rescue Exception => e
      errors.add(:search_engine_ids, "some search_engines could not be found")
    end
  end

  def get_all_date_pairs

    parsed_date_string = date_string.match /\A\s*\((.*)\)\s*\+\s*(\d*)\s*\*\s*(\d*)/

    # get the base date
    base_date_pair = parsed_date_string[1].match(/\((.*?)\)/)[1].split(',').map { |date| Date.parse date.strip }
    date_pairs = [base_date_pair]

    # add our modifiers to our set
    parsed_date_string[1].scan(/\((.*?)\)/).drop(1).each do |pair|
      date_pairs << base_date_pair.zip(pair.first.split(',').map(&:strip)).map { |(base_date, offset)| calculate_offset_from_base_date(base_date, offset) }
    end

    # get the multiplier in
    adder = parsed_date_string[-2].to_i
    multiplier = parsed_date_string[-1].to_i

    date_pairs.map! { |(start_date, end_date, strike_date)| (0..multiplier).to_a.map { |x| [start_date + (adder * x).days, end_date + (adder * x).days, strike_date + (adder * x).days ] } }

    date_pairs.flatten(1)

  end

  def calculate_offset_from_base_date(base_date, offset)
    case offset[0]
    when '+'
      return base_date + offset[1..-1].to_i
    when '-'
      return base_date - offset[1..-1].to_i
    else
      return base_date
    end
  end
  
end
