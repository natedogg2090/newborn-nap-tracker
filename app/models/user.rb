class User < ActiveRecord::Base
  has_many :babies
  has_secure_password

  # validates :name, :pressence => true
  # validates :email, :pressence => true
  # validates :password, :pressence => true

end