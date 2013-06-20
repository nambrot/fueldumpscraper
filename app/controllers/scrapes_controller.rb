class ScrapesController < ApplicationController
  respond_to :html
  def new
    @scrape = Scrape.new

  end

  def create
    params[:scrape][:base_route_ids].pop(1) if params[:scrape][:base_route_ids].last == ''
    params[:scrape][:strike_ids].pop(1) if params[:scrape][:strike_ids].last == ''
    params[:scrape][:search_engine_ids].pop(1) if params[:scrape][:search_engine_ids].last == ''
    without_strike = true if params[:scrape][:strike_ids].delete '0'
    
    @scrape = Scrape.new params[:scrape].permit(:base_route_ids, :strike_ids, :search_engine_ids, :date_string)
    @scrape.base_route_ids = params[:scrape][:base_route_ids]
    @scrape.strike_ids = params[:scrape][:strike_ids]

    @scrape.search_engine_ids = params[:scrape][:search_engine_ids]
    
    if @scrape.valid?
      @priced_base_routes = []
      @priced_strike_routes = []
      # create all the priced thingys
      @scrape.get_all_date_pairs.each do |(start_date, end_date, strike_date)|
        @scrape.base_routes.each do |base_route|
          @scrape.search_engines.each do |search_engine|
            
            @scrape.strikes.each do |strike|
              @priced_strike_routes << PricedStrikeRoute.create(:search_engine => search_engine, :start_date => start_date, :end_date => end_date, :base_route => base_route, :strike => strike, :strike_date => strike_date).scrape_price
            end

            if without_strike
              @priced_base_routes << PricedBaseRoute.create(:search_engine => search_engine, :start_date => start_date, :end_date => end_date, :base_route => base_route).scrape_price
            end

          end
        end
      end

      render 'success'
    else
      render 'new'
    end
  end

  def index
    raise
    redirect_to :root
  end
end
