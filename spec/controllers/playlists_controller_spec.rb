require "rails_helper"

RSpec.describe PlaylistsController, type: :controller do
  describe "GET #shuffle" do
    it "returns http success" do
      pending
      patch :shuffle
      expect(response).to have_http_status(:success)
    end
  end
end
