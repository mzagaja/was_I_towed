require 'open-uri'
class StaticPagesController < ApplicationController

  def home
  end

  def towed
    vehicle_plate = params[:q]
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$where=vehicle_plate%20=%20\''
    full_url = base_url + vehicle_plate + "\'"
    car = JSON.parse(open(full_url).read)
    if car.first.nil? 
      @body = "No, keep looking."
    else
      @body = "Shit, yes it was."
      @car = car
    end
  end
end