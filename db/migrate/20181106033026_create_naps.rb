class CreateNaps < ActiveRecord::Migration
  def change
    create_table :naps do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.text :notes
      t.integer :baby_id
    end
  end
end
