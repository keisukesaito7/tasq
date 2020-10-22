class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:create]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save
      redirect_to task_path(@task)
    else
      redirect_to task_path(@task)
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).marge(user_id: current_user.id, task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
