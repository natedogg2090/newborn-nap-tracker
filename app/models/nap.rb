class Nap < ActiveRecord::Base
  belongs_to :baby

  validates :start_time, :end_time, :notes, :baby_id, :presence => true

end