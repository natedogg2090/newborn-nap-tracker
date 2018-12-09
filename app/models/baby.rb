class Baby < ActiveRecord::Base
  belongs_to :user
  has_many :naps

  validates :name, :presence => true
  validates :birthday, :presence => true
  validates :user_id, :presence => true

end