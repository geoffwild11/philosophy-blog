class User < ActiveRecord::Base
  
  # User info
  validates :name, presence: true, length: { maximum: 50 }
  
  # Email info
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
              format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
end
