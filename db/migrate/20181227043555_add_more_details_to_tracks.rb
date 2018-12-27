class AddMoreDetailsToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :start_time, :datetime
  end
end
