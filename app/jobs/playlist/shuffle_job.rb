class Playlist::ShuffleJob < ApplicationJob
  queue_as :default

  def perform(playlist)
    # I'm running these inline, so capture exceptions more explicitly.

    playlist.user.refesh_spotify_token!
    playlist.shuffle_tracks! unless playlist.user.spotify_token_expired?
  rescue StandardError => e
    Raven.capture_exception(e)
  end
end
