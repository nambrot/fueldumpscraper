class BaseRoutesController < ApplicationController
  respond_to :json, :html
  
  def index
    @base_routes = BaseRoute.all
  end

  def show
    @base_route = BaseRoute.find params[:id]
  end

  def new
    @base_route = BaseRoute.new
  end

  def create
    @base_route = BaseRoute.create params[:base_route].permit(:origin, :destination)
    respond_with @base_route
  end

end
