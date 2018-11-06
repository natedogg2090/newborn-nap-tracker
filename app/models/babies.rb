class Babies < ActiveRecord::Base
  belongs_to :user
  has_many :naps

end