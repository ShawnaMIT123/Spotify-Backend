class AddOwnerToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :owner_id, :integer
  end
end
