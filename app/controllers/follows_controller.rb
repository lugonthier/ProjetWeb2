class FollowsController < ApplicationController
    before_action do
        @user = User.find(params[:user_id])
    end

    def create
        @user.followers << current_user
        redirect_to @user, success:"Vous êtes abonné à " +  @user.firstname
    end
    

    def destroy

        @user.followers.delete(current_user)
        redirect_to @user, success:"Vous êtes désabonné de " + @user.firstname 
    end

    def show
        @posts = @user.posts.all

    end

end
