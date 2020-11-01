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
    @permissions = @task.permissions.excepted(current_user)
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path
    else
      redirect_to task_path(@task)
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
    if current_user.id != @task.user_id && !permission_exist?
      redirect_to root_path
    end
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
