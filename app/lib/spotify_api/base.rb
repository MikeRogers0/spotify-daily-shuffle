class SpotifyApi::Base
  include HTTParty
  base_uri 'https://api.spotify.com/v1'

  def initialize(client_id: nil, client_secret: nil, oauth_token: nil, user_id: nil)
    @client_id = client_id || ENV['SPOTIFY_CLIENT_ID']
    @client_secret = client_secret || ENV['SPOTIFY_CLIENT_SECRET']
    @oauth_token = oauth_token
    @user_id = user_id
  end

  def headers
    authorization = Base64.strict_encode64 "#{@client_id}:#{@client_secret}"
    { 'Authorization': "Basic #{authorization}" }
  end
end
