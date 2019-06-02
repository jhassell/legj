class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer :member_id
      t.integer :committee_id

      t.timestamps
    end
  end
end
