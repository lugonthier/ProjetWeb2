class FollowController < ApplicationController
    
    before_action do
        @user = User.find(params[:user_id])
    end

    def create
        @user.followers << current_user
        redirect_to @user, success:"Vous êtes abonné à <%= @user.name %>"
    end

    def destroy

        @user.followers.delete(current_user)
        redirect_to @user, success:"Vous êtes désabonné de <%= @user.name %>"
    end


end