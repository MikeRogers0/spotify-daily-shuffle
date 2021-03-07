class Playlist < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  before_save :create_on_spotify!, unless: :spotify_playlist_id?

  def self.build_from(user)
    new({
      user: user,
      name: "My Morning Shuffle#{" (Dev)" if Rails.env.development?}",
      description: "Have a freshly shuffled playlist every day, perfect for connecting to Amazon Alexa. Made by: https://spotify-daily-shuffle.mikerogers.io/"
    })
  end

  def self.shuffle_all
    Playlist.where(updated_at: [Time.at(0)..8.hours.ago]).find_each do |playlist|
      Playlist::ShuffleJob.perform_now(playlist)
    end
  end

  def create_on_spotify!
    playlist = playlist_api.create(user.uid, {
      name: name,
      description: description,
      public: false
    })

    self.spotify_playlist_id = playlist["id"]
    self.spotify_href = playlist["href"]
    add_default_tracks_to_playlist!
  end

  def add_default_tracks_to_playlist!
    # Now add some tracks:
    playlist_api.add_tracks(spotify_playlist_id, [
      "spotify:track:1M2zeYn9S4zorVjz05oZw1",
      "spotify:track:25ARMOqslllxRWM5meNGbW",
      "spotify:track:4IlB0WKdchGUPa4WoAYy5D",
      "spotify:track:6xy6jNeNTYwjnKTDzMyHw2",
      "spotify:track:2IIWHk7OjVmEyPwKVCgWKz",
      "spotify:track:4KcH1ZRV2W1q7Flq0QqC76"
    ])
  end

  def total_tracks
    @total_tracks ||= playlist_api.all_tracks(spotify_playlist_id, fields: "total")["total"]
  end

  def track_uris
    return [] if total_tracks.nil? || total_tracks.zero?

    @track_uris ||= (0..total_tracks).step(100).collect do |index|
      (playlist_api.all_tracks(spotify_playlist_id, offset: index)["items"] || []).collect { |item| item.dig("track", "uri") }
    end.flatten.compact.uniq
  end

  # Figure how to do this when more then 100 tracks.
  def shuffle_tracks!
    #  Cache the current set of tracks, unless it's blank for some reason.
    update(tracks: track_uris.shuffle) if track_uris.any?

    if tracks.present? && tracks.any?
      playlist_api.replace_tracks(spotify_playlist_id, [])

      # Readd in new order
      tracks.in_groups_of(100, false).each_with_index do |shuffled_groups, _index|
        playlist_api.add_tracks(spotify_playlist_id, shuffled_groups)
      end
    end
  end

  def refresh_details!
    return false if spotify_href.present? && image_url.present? && updated_at > 10.minutes.ago

    update(
      name: spotify_playlist["name"],
      description: spotify_playlist["description"],
      image_url: spotify_playlist["images"].present? ? spotify_playlist["images"].first["url"] : nil,
      spotify_href: spotify_playlist["external_urls"]["spotify"],
      public: spotify_playlist["public"]
    )
  end

  private

  def spotify_playlist
    @spotify_playlist ||= playlist_api.find(spotify_playlist_id)
  end

  def all_tracks
    @all_tracks ||= playlist_api.all_tracks(spotify_playlist_id)
  end

  def playlist_api
    @playlist_api ||= SpotifyApi::Playlist.new(oauth_token: user.spotify_token)
  end
end
