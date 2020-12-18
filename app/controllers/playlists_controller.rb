class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def shuffle
    Playlist::ShuffleJob.perform_now(playlist)
    head :ok
  end

  private

  def playlist
    @playlist ||= current_user.playlists.find(params[:id])
  end
end
