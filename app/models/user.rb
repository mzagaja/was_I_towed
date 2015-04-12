class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, length: { maximum: 200 }
  validates :vehicle_license, presence: true, length: { maximum: 8 }
  validates :telephone_number, length: { maximum: 10 }, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  has_secure_password # validations: false Remove this line later
  has_many :tows, foreign_key: "Vehicle_Plate", primary_key: "vehicle_license"

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def sms_alert(text)
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '8607856371', to: self.telephone_number, body: text
    render plain: message.status
  end
end