class UserInformationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_information =
      current_user.user_information ||
      current_user.build_user_information
  end

  def edit
    @user_information =
      current_user.user_information ||
      current_user.build_user_information
  end

  def update
    @user_information =
      current_user.user_information ||
      current_user.build_user_information

    if @user_information.update(user_information_params)
      redirect_to profile_path,
                  notice: "Profile updated."
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  private

  def user_information_params
    params.require(:user_information)
          .permit(
            :goal,
            :restrictions,
            :birthday,
            :weight,
            :height
          )
  end
end
