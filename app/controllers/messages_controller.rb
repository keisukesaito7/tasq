class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:create]

  def create
    message = Message.create(message_params)
    render json: { message: message }
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, task_id: params[:task_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
