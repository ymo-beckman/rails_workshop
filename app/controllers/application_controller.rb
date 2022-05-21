class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    Current.user = User.find(session[:user_id]) if session[:user_id]
    Current.user_profile = Current.user.user_profile if Current.user
  end
end
