class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in, only:[:categories, :index, :show]
  
  # GET /posts
 
  def me
    @posts = current_user.posts.all
  end

  def index
    user_ids = current_user.followed_users.pluck(:id)
    @posts = Post.joins(:user).where(users: {id: user_ids})
    #comparer les dates de photos, et mettre la plus récente en haut... tu t'en rappeleras.
  end
=begin
  def categories

    @categories = SportCategorie.find_by_slug!(params[:slug])
    @posts = Post.joins(:sports).where(sports: {sport_categorie_id: @categories.id})
  end
=end
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

  def create
    @post = current_user.posts.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to me_posts_path, success: 'Votre post a été créé avec succès.' }
       
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
        format.html { redirect_to me_posts_path, success: 'Votre post a été modifié.' }
      
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
      format.html { redirect_to me_posts_path, success: 'Votre poste a été détruit.' }
   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :content, :photo_file, :sport_id)
    end
end
