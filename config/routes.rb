Rails.application.routes.draw do
  devise_for :users, path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "start-shuffling",
    registration: "register"
  },
                     controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  get :uptime_check, path: "uptime-check", to: proc { [200, {}, ["Hello Robot - We're still up"]] }

  namespace :users, path: "" do
    resource :datas, only: [], path: "data" do
      get :index
      post :export
      delete :destroy
    end
  end

  resources :playlists, only: [] do
    member do
      patch :shuffle
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "landings#index"
end
