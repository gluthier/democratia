class UsersController < ApplicationController

  def messages
    @user = User.includes(:comments).find_by(id: params[:id])
    if @user.nil?
      render json: {status: 422 }
      return
    end
    @comments = @user.comments.order(:cached_weighted_average => :desc)
    render layout: false
  end

end
