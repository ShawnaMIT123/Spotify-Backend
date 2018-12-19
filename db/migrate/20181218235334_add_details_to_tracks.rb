class AddDetailsToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :title, :string
    add_column :tracks, :artist, :string
    add_column :tracks, :img_url, :string
    add_column :tracks, :duration_ms, :integer
  end
end
