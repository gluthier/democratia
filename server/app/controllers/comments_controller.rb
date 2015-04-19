class CommentsController < ApplicationController

    protect_from_forgery :except => :create 

    def comments_for_user
        @comments = Comment.where(user_id: params[:user_id])
        if @comment.nil?
            render json: {status: 442}
            return
        end
        render 'users/messages', layout: false
    end

    def create
	Comment.create(title: params[:titre], content: params[:description], user_id: params[:user_id])
    	@user = User.includes(:comments).find_by(id: params[:user_id])
    	if @user.nil?
      		render json: {status: 422 }
      		return
    	end
    	@comments = @user.comments.order(:cached_weighted_average => :desc)
	render 'users/messages', layout: false
    end
end
