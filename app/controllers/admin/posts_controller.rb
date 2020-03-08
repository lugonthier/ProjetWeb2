module Admin
    class PostsController < ApplicationController
        before_action :set_post, only: [ :destroy, :show]



        
        def index
            @posts = Post.all
        end

        def show
            @post = Post.find(params[:id])
        end

        

        def destroy
            @post.destroy

            redirect_to( admin_posts_path, success: "le post a été supprimé")

        end

        private
        def set_post
            @post = Post.find(params[:id])

        end


    end
end

