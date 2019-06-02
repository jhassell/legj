class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :member_type
      t.string :member_title
      t.string :last_name
      t.string :first_name

      t.timestamps
    end
  end
end
