class AddUserColumnToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :user_id, :integer
  end
end
