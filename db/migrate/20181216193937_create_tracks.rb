class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.integer :room_id
      t.string :spotify_url

      t.timestamps
    end
  end
end
