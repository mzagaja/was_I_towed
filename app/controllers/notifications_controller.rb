class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '8607856371', to: '8608838042', body: 'Learning to send SMS you are.'
    render plain: message.status
  end

  def receive
    vehicle_plate = params["Body"]
    from_number = params["From"]
    base_url = 'https://data.hartford.gov/resource/hefc-wgp8.json?$where=vehicle_plate%20=%20\''
    full_url = base_url + vehicle_plate + "\'"
    car = JSON.parse(open(full_url).read)
    if car.first.nil? 
      response = Twilio::TwiML::Response.new do |r|
        r.Message 'No, keep looking.'
      end.text
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Message 'Shit yes it was.'
      end.text
    end
  end
end