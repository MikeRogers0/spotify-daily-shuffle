class SpotifyApi::Token < SpotifyApi::Base
  base_uri 'https://accounts.spotify.com/api'

  def refresh_token(spotify_refresh_token)
    self.class.post('/token?refresh_token', {
                      body: {
                        grant_type: 'refresh_token',
                        refresh_token: spotify_refresh_token
                      },
                      headers: headers
                    })
  end
end
