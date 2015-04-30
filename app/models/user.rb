class User < ActiveRecord::Base
  
  # User info
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  
  # Email info
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
              format: { with: VALID_EMAIL_REGEX }, 
              uniqueness: { case_sensitive: false }
  
  # Password
  has_secure_password
  validates :password, length: { minimum: 8 }
end
