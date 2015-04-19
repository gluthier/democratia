class SessionsController < ApplicationController
    def create
        commenter = Commenter.from_ominauth(env["omniauth.auth"])
        session[:commenter_id] = commenter.id
        redirect_to root_url
    end

    def destroy
        session[:commenter_id] = nil
        redirect_to root_url
    end
end
