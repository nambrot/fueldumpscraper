class PricedBaseRoutesController < ApplicationController
  respond_to :json, :html

  def new
    @base_route = BaseRoute.find params[:base_route_id]
    @priced_base_route = @base_route.priced_base_routes.build params[:priced_base_routes]
  end

  def create
    @base_route = BaseRoute.find params[:base_route_id]
    respond_with @priced_base_route
  end

  def show
    @priced_base_route = PricedBaseRoute.find params[:id]
  end

  def index

  end

end
