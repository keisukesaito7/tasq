class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_user, only: [:index, :new, :create]

  def index
    @tasks = @user.tasks.order('created_at DESC')
  end

  def new
    @task = Task.new
  end

  def craete
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to :index
    else
      render :new
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def task_params
    params.require(:task).permit(:title, :purpose, :goal)
  end
  
end
