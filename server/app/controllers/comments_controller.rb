class CommentsController < ApplicationController

    def comments_for_user
        @comments = Comment.where(user_id: params[:user_id])
        if @comment.nil?
            render json: {status: 442}
            return
        end
        render 'users/messages', layout: false
    end
end
