class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top]
  before_action :set_tasks, only: [:top]

  def top
  end

  private

  def set_tasks
    if user_signed_in?
      # 自分が作ったタスク
      @my_tasks = current_user.tasks.order('created_at DESC')
      # レビュー許可されたタスク
      @permitted_tasks = Task.as_reviewer(current_user)
    end
  end
end
