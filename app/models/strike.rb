class Strike < ActiveRecord::Base

  def to_s
    "#{origin}-#{destination}"
  end
end
