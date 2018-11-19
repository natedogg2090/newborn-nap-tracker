class ChangeBabiesBirthdayType < ActiveRecord::Migration
  def change
    change_column :babies, :birthday, :date
  end
end
