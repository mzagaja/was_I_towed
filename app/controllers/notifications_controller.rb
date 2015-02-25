class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '8607856371', to: '8608838042', body: 'Learning to send SMS you are.'
    render plain: message.status
  end

  def receive
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    vehicle_plate = params["Body"]
    from_number = params["From"]
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$where=vehicle_plate%20=%20\''
    full_url = base_url + vehicle_plate + "\'"
    car = JSON.parse(open(full_url).read)
    if car.first.nil? 
      message = client.messages.create from: '8607856371', to: '8608838042', body: 'No, keep looking.'
    else
      message = client.messages.create from: '8607856371', to: '8608838042', body: 'Shit, yes it was.'
    end
  end
end