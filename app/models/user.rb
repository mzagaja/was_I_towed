class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  before_validation { self.vehicle_license = vehicle_license.gsub(/[^A-Za-z0-9]/, "") }
  before_validation { self.telephone_number = telephone_number.gsub(/[^0-9]/, "") }
  validates :name, length: { maximum: 200 }
  validates :vehicle_license, presence: true, length: { maximum: 8 }
  validates :telephone_number, length: { is: 10 }, uniqueness: true
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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
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
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end