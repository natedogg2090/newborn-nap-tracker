class User < ActiveRecord::Base
  has_many :babies
  has_secure_password

end