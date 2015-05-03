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
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
