class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        @user.user_profile = UserProfile.new
        @user.user_profile.save

        session[:user_id] = @user.id
        redirect_to edit_user_profile_path(@user.user_profile), notice: 'Successfully create account'
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
