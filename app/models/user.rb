class User < ActiveRecord::Base
  validates :vehicle_license, presence: true
end
