class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect(user, event: :authentication)
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      Sentry.capture_message(user.errors.inspect)
      redirect_to root_path, alert: t(".alert")
    end
  end

  def failure
    redirect_to root_path
  end
end
