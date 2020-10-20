class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_user, only: [:index]

  def index
    @tasks = @user.tasks.order('created_at DESC')
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
  
end
