module ScrapesHelper

  def all_strikes
    [Strike.new(:id => 0, :origin => "Without Strike")] + Strike.all
  end

end
