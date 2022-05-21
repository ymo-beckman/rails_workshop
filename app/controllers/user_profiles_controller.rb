class UserProfilesController < ApplicationController
  def index
    @user_profile = Current.user_profile
  end

  def edit
    @user_profile = Current.user_profile
  end

  def update
    # @type [UserProfile] @user_profile
    @user_profile = Current.user_profile

    @user_profile.first_name = user_profile_params[:first_name]
    @user_profile.last_name = user_profile_params[:last_name]

    @user_profile.save

    @user_profile.avatar.attach(user_profile_params[:avatar])

    @user_profile.avatar_url = url_for(@user_profile.avatar)
    @user_profile.save

    redirect_to root_path
  end

  private
  def user_profile_params
    params.require(:user_profile).permit(:first_name, :last_name, :avatar)
  end
end
