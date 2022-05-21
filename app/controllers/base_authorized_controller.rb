class BaseAuthorizedController < ApplicationController
  before_action :require_user_logged_in!

  def require_user_logged_in!
    redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
  end
end
