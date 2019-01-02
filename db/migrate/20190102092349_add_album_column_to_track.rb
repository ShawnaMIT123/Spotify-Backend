class AddAlbumColumnToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :album, :string
  end
end
