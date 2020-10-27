class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      # 修正ポイント（permissionも同時に保存したい）
      Permission.create(user_id: current_user.id, task_id: @task.id)
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show
    @commit = Commit.new
    @commits = @task.commits.order('created_at DESC')
    @message = Message.new
    @messages = @task.messages.includes(:user).order('created_at DESC')
    @permission = Permission.new
    @permissions = @task.permissions.where.not(user_id: [current_user.id, @task.user_id]).includes(:user).order('created_at DESC')
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :show
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :purpose, :goal).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_permission
    redirect_to root_path unless permission_exist?
  end

  def permission_exist?
    permission = @task.permissions.where(user_id: current_user.id)
    if permission.any?
      true
    else
      false
    end
  end

  def check_owner
    redirect_to root_path if @task.user_id != current_user.id
  end
end
