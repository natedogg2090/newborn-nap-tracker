class Nap < ActiveRecord::Base
  belongs_to :baby

  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :notes, :presence => true
  validates :baby_id, :presence => true

end