class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]
  before_action :check_person, only: [:show]

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_person
    redirect_to root_path if current_user.id != @user.id
  end
end
