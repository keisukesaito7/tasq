class HomeController < ApplicationController
  before_action :set_tasks, only: [:top]

  def top
  end

  private

  def set_tasks
    if user_signed_in?
      @tasks = current_user.tasks.order('created_at DESC')
    end
  end
  
end
