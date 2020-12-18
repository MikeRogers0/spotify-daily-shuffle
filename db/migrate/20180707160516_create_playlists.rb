class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.references :user, foreign_key: true
      t.string :spotify_playlist_id
      t.string :name
      t.string :description
      t.string :image_url
      t.string :spotify_href
      t.boolean :public
      t.json :tracks

      t.timestamps
    end
  end
end
