class SpotifyApi::User < SpotifyApi::Base
  def playlists(offset: 0)
    self.class.get("/me/playlists?limit=50&offset=#{offset}", {
      headers: headers
    })
  end

  private

  def headers
    {
      'Authorization': "Bearer #{@oauth_token}",
      'Content-Type': "application/json"
    }
  end
end
