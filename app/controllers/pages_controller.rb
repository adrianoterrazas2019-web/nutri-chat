class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :authenticate_user!, only: :profile

  def home
  end

  def profile
    @user_information = current_user.user_information
  end
end
