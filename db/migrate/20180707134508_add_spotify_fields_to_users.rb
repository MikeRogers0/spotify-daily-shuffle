class AddSpotifyFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :country_code, :string
    add_column :users, :image_url, :string
    add_column :users, :url, :string
    add_column :users, :product, :string

    # Spotify tokens
    add_column :users, :spotify_refresh_token, :string
    add_column :users, :spotify_expires_at, :datetime
    add_column :users, :spotify_token, :string
  end
end
