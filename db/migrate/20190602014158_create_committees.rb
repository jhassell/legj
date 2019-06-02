class CreateCommittees < ActiveRecord::Migration[5.2]
  def change
    create_table :committees do |t|
      t.string :name
      t.string :meeting_day
      t.string :meeting_time
      t.string :meeting_room

      t.timestamps
    end
  end
end
