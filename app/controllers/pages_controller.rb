class PagesController < ApplicationController
  def index
    @posts = Post.limit(10)
    @sport_categories = SportCategorie.all
    @users = User.limit(5)
  end
end
