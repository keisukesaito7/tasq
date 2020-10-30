class HomeController < ApplicationController
  before_action :set_tasks, only: [:top]

  def top
  end

  private

  def set_tasks
    if user_signed_in?
      # 自分が作ったタスク
      @my_tasks = current_user.tasks.as_owner(current_user.id)
      # レビュー許可されたタスク
      @permitted_tasks = current_user.tasks.as_reviewer(current_user.id)
    end
  end
end
