class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:create]

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      redirect_to task_path(@task)
    else
      @commit = Commit.new
      @commits = @task.commits.order('created_at DESC')
      @messages = @task.messages.includes(:user).order('created_at DESC')
      render "/tasks/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
