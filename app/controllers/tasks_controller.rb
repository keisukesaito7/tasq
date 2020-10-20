class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show,:edit, :update]
  before_action :set_task, only: [:show, :edit, :update]
  before_action :check_person, only: [:show, :edit, :update]

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

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
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

  def check_person
    redirect_to tasks_path if @task.user.id != current_user.id
  end
  
end
