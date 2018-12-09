class Baby < ActiveRecord::Base
  belongs_to :user
  has_many :naps

  validates :name, :birthday, :user_id, :presence => true
  
  before_validation :capitalize_name

  def capitalize_name
    name.capitalize
  end


end