class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:spotify]

  has_many :playlists, dependent: :destroy

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: {scope: :provider}

  validates :name, presence: true
  # validates :country_code, presence: true
  # validates :image_url, presence: true
  validates :url, presence: true
  validates :product, presence: true

  validates :spotify_refresh_token, presence: true
  validates :spotify_token, presence: true
  validates :spotify_expires_at, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # Set a password so devise is a happy camper
      user.password = Devise.friendly_token[0, 64]

      user.spotify_credentials = auth.credentials
      user.spotify_info = auth.info

      user.playlists << Playlist.build_from(user)
    end.tap do |user|
      user.spotify_credentials = auth.credentials
      user.spotify_info = auth.info
    end
  end

  def to_s
    name
  end

  def spotify_credentials=(credentials)
    self.spotify_refresh_token = credentials.refresh_token
    self.spotify_token = credentials.token
    self.spotify_expires_at = Time.at(credentials.expires_at)
  end

  def spotify_info=(info)
    self.name = info.name
    self.country_code = info.country_code
    self.image_url = info.image
    self.url = info.urls.first
    self.product = info.product
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def spotify_token_expired?
    Time.zone.now > spotify_expires_at
  end

  def refesh_spotify_token!
    return unless spotify_token_expired?

    response = SpotifyApi::Token.new.refresh_token(spotify_refresh_token)

    if response["access_token"].present?
      update(
        spotify_token: response["access_token"],
        spotify_expires_at: Time.zone.now + (response["expires_in"] || -100),
        spotify_refresh_token: response["refresh_token"] || spotify_refresh_token
      )
    else
      false
    end
  end

  def spotify_playlists(offset: 0)
    @spotify_playlists ||= SpotifyApi::User.new(oauth_token: spotify_token).playlists(offset: offset)
  end
end
