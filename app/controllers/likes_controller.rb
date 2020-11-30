class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like = Like.create(user_id: current_user.id, task_id: params[:task_id], commit_id: params[:commit_id])
    redirect_to task_path(Task.find(params[:task_id]))
  end

end
