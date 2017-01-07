require 'open-uri'
class StaticPagesController < ApplicationController

  def home
  end

  def towed
    vehicle_plate = params[:q].gsub(/[^A-Za-z0-9]/, "")
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$where=vehicle_plate%20=%20\''
    full_url = base_url + vehicle_plate + "\'"
    car = JSON.parse(open(full_url).read)
    if car.first.nil?
      @body = "Unfortunately we do not know where your car is yet.
               We might know for up to three hours from the tow.
               If you click below we will text or e-mail you when we know."
    else
      @body = "Shit, yes it was."
      @car = car
    end
  end
end
