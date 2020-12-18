class SpotifyApi::Playlist < SpotifyApi::Base
  def create(user_id, playlist)
    self.class.post("/users/#{user_id}/playlists", {
                      body: playlist.to_json,
                      headers: headers
                    })
  end

  def update(playlist_id, payload)
    self.class.put("/playlists/#{playlist_id}", {
                     body: payload.to_json,
                     headers: headers
                   })
  end

  def all_tracks(playlist_id, offset: 0, fields: 'total,offset,limit,href,items(track.id,track.uri)')
    self.class.get("/playlists/#{playlist_id}/tracks?offset=#{offset}&fields=#{ERB::Util.url_encode fields}", {
                     headers: headers
                   })
  end

  def add_tracks(playlist_id, track_uris)
    self.class.post("/playlists/#{playlist_id}/tracks", {
                      body: {
                        position: 0,
                        uris: track_uris
                      }.to_json,
                      headers: headers
                    })
  end

  def find(playlist_id, fields: 'name,description,public,images(url),external_urls(spotify)')
    self.class.get("/playlists/#{playlist_id}?fields=#{ERB::Util.url_encode fields}", {
                     headers: headers
                   })
  end

  def replace_tracks(playlist_id, track_uris)
    self.class.put("/playlists/#{playlist_id}/tracks", {
                     body: {
                       uris: track_uris.collect { |track_uri| { uri: track_uri } }
                     }.to_json,
                     headers: headers
                   })
  end

  def remove_tracks(playlist_id, track_uris)
    self.class.delete("/playlists/#{playlist_id}/tracks", {
                        body: {
                          tracks: track_uris.collect { |track_uri| track_uri }
                        }.to_json,
                        headers: headers
                      })
  end

  private

  def headers
    {
      'Authorization': "Bearer #{@oauth_token}",
      'Content-Type': 'application/json'
    }
  end
end
