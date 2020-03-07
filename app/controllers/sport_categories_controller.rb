class SportCategoriesController < ApplicationController

    def new
        @sport_categorie = SportCategorie.new
       
    end

    def edit
        
    end
###
    def show
        @sport_categorie = SportCategorie.find(params[:id])
        @sports = @sport_categorie.sports.all

    end

    def index
        @sport_categories = SportCategorie.all
    end

    def create
       
        @sport_categorie = SportCategorie.new(sport_categorie_params)
        if @sport_categorie.save

            redirect_to sport_categories_path, success: 'Vous avez ajouté une nouvelle catégorie de sport !'
        else
            render :new
        end
    end
    
    def update

    end


    private 

    def sport_categorie_params
        params.require(:sport_categorie).permit(:name, :slug)
    
    end
end