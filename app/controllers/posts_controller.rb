class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :only_signed_in, only:[:categories, :index, :show]
  
  # GET /posts
 
  def me
    @posts = current_user.posts.all
  end

  def index
    user = current_user
    @followees = current_user.followed_users

    @followees_id = []
    for i in @followees
      @followees_id << i.followee_id
    end
    @posts = followeePosts(@followees_id)

  end
  
=begin
  def categories

    @categories = SportCategorie.find_by_slug!(params[:slug])
    @posts = @categorie.posts.all
    #@posts = Post.joins(:sports).where(sports: {sport_categorie_id: @categories.id})
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


  def followeePosts(ids)
    #retourne les 5 derniers posts de chacun de ses abonnements dans un array.
    users = User.where({id: ids})
    length = ids.length
    filter = []
    
    
    if length != 0
        for i in (0..(length-1))
          if users[i] != nil # Si jamais un utilisateur a été supprimé, il sera nil
            if users[i].posts.all.length > 4
                for j in ((length - 5)..(length-1))
                    filter << users[i].posts[j]
                end
            else
                for k in users[i].posts
                    filter << k
                end
            end
          end
        end
        #Tri bulle pour trier par date.

        if filter.length > 1
            x = filter.length-1
            while x >= 1
                
                for j in (0..(x-1))
                    
                    if filter[j+1].created_at < filter[j].created_at
                        switch = filter[j+1]
                        filter[j+1] = filter[j]
                        filter[j] = switch
                    end
                end
                x = x-1
            end

        end

    end

   filter


    
end


    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :content, :photo_file, :sport_id)
    end
end
