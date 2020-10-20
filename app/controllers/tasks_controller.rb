class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show]
  before_action :set_task, only: [:show]
  before_action :check_person, only: [:show]

  def index
    @tasks = current_user.tasks.order('created_at DESC')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
  end

  private
  def task_params
    params.require(:task).permit(:title, :purpose, :goal).merge(user_id: @user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_person
    redirect_to tasks_path if @task.user.id != current_user.id
  end
  
end
