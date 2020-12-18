class LandingsController < ApplicationController
  def index
    (current_user&.playlists || []).each(&:refresh_details!)
  end
end
