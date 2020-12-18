class Users::DatasController < ApplicationController
  before_action -> { authenticate_user! }

  def index; end

  def destroy
    current_user.destroy
    sign_out(current_user)
    redirect_to root_path, notice: t('.notice')
  end

  def export
    respond_to do |format|
      format.json do
        render json: current_user.to_json(include: [:playlists])
      end
    end
  end
end
