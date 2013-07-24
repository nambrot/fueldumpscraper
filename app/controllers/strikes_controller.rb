class StrikesController < ApplicationController
  respond_to :json, :html

  def index
    @strikes = Strike.all
  end

  def new
    @strike = Strike.new
  end

  def create
    @strike = Strike.create params[:strike].permit(:origin, :destination)
    respond_with @strike
  end

  def show

  end

end
