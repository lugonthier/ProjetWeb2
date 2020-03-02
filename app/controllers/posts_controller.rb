class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user.posts
  end


  def show
    @post = Post.find(params[:id])

  end

 
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, success: 'Votre post a été créé avec succès.' }
       
      else
        format.html { render :new }
 
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, succès: 'Votre post a été modifié.' }
      
      else
        format.html { render :edit }

      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url,succès: 'Votre poste a été détruit.' }
   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :content, :photo_file)
    end
end
