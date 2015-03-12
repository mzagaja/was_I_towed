class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, length: { maximum: 200 }
  validates :vehicle_license, presence: true, length: { maximum: 8 }
  validates :telephone_number, length: { maximum: 10 }, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  has_secure_password validations: false
end