class PermissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_task, only: [:create, :destroy]
  before_action :check_owner, only: [:create, :destroy]

  def create
    @permission = Permission.new(permission_params)
    if @permission.valid?
      # タスクオーナーの場合は保存しない
      @permission.save unless current_user.id == permission_params[:user_id].to_i
      redirect_to task_path(@task)
    else
      @commit = Commit.new
      @commits = @task.commits.order('created_at DESC')
      @message = Message.new
      @messages = @task.messages.includes(:user).order('created_at DESC')
      @permissions = @task.permissions.excepted(current_user)
      render 'tasks/show'
    end
  end

  def destroy
    permission = Permission.find(params[:id])
    if permission.destroy
      redirect_to task_path(@task)
    else
      redirect_to task_path(@task)
    end
  end

  private

  def permission_params
    params.require(:permission).permit(:user_id).merge(task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def check_owner
    redirect_to task_path(@task) if @task.user_id != current_user.id
  end
end
