class HomeController < ApplicationController
  before_action :check_signin, only: [:top]

  def top
  end

  private
  def check_signin
    redirect_to tasks_path if user_signed_in?
  end
end
