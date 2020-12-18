class ApplicationController < ActionController::Base
  before_action :current_user_refresh_spotify_token!, if: :current_user
  before_action :set_raven_context

  private

  def current_user_refresh_spotify_token!
    current_user.refesh_spotify_token!

    return unless current_user.spotify_token_expired?

    sign_out(current_user)
    redirect_to user_spotify_omniauth_authorize_path
  end

  def set_raven_context
    Raven.user_context(id: session['warden.user.user.key']&.first&.first)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url, subdomain: request.subdomain)
  end
end
