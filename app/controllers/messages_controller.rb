class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:create, :destroy]
  before_action :check_person, only: [:destroy]

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      redirect_to task_path(@task)
    else
      @commit = Commit.new
      @commits = @task.commits.order('created_at DESC')
      @messages = @task.messages.includes(:user).order('created_at DESC')
      @permission = Permission.new
      @permissions = @task.permissions.excepted(current_user)
      render '/tasks/show'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to task_path(@task)
    else
      redirect_to task_path(@task)
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def check_person
    @message = Message.find(params[:id])
    redirect_to root_path if @message.user_id != current_user.id
  end
end
