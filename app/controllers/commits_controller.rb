class CommitsController < ApplicationController
  before_action :set_task, only: [:create, :edit, :update, :destroy]
  before_action :set_commit, only: [:edit, :update, :destroy]
  before_action :check_person, only: [:create, :edit, :update, :destroy]

  def create
    @commit = Commit.new(commit_params)
    if @commit.valid?
      @commit.save
      redirect_to task_path(@task)
    else
      @commits = @task.commits.order('created_at DESC')
      @message = Message.new
      @messages = @task.messages.includes(:user).order('created_at DESC')
      @permission = Permission.new
      @permissions = @task.permissions.excepted(current_user)
      render '/tasks/show'
    end
  end

  def edit
  end

  def update
    if @commit.update(commit_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    if @commit.destroy
      redirect_to task_path(@task)
    else
      redirect_to task_path(@task)
    end
  end

  private

  def commit_params
    params.require(:commit).permit(:content).merge(user_id: current_user.id, task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_commit
    @commit = Commit.find(params[:id])
  end

  def check_person
    redirect_to root_path if @task.user_id != current_user.id
  end
end
