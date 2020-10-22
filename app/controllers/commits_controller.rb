class CommitsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :craete, :edit, :update]
  before_action :set_task, only: [:new, :create, :edit, :update]
  before_action :set_commit, only: [:edit, :update]
  before_action :check_person, only: [:new, :create, :edit, :update]

  def new
    @commit = Commit.new
  end

  def create
    @commit = Commit.new(commit_params)
    if @commit.valid?
      @commit.save
      redirect_to task_path(@task)
    else
      render :new
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
    redirect_to tasks_path if @task.user_id != current_user.id
  end

end
