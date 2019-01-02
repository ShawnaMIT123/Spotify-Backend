class AddUserNameColumnToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :user_name, :string
  end
end
