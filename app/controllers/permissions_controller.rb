class PermissionsController < ApplicationController
  before_action :set_task, only: [:create]

  def create
    @permission = Permission.new(permission_params)
    if @permission.valid?
      @permission.save
      redirect_to task_path(@task)
    else
      @commit = Commit.new
      @commits = @task.commits.order("created_at DESC")
      @message = Message.new
      @messages = @task.messages.includes(:user).order("created_at DESC")
      render "tasks/show"
    end
  end

  private

  def permission_params
    params.require(:permission).permit(:user_id).merge(task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
