class HomeController < ApplicationController
  before_action :set_tasks, only: [:top]

  def top
  end

  private

  def set_tasks
    if user_signed_in?
      # 自分が作ったタスク
      @my_tasks = current_user.tasks.where(user_id: current_user.id).order('created_at DESC')
      # レビュー許可されたタスク
      @permitted_tasks = current_user.tasks.where.not(user_id: current_user.id).order('created_at DESC')
    end
  end
  
end
