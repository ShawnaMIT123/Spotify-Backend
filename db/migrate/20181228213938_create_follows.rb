class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :participant_id
      t.integer :room_id

      t.timestamps
    end
  end
end
