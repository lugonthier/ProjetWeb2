module Admin
    class SportCategoriesController < ApplicationController
        
        before_action :set_sport_categories, only: [:update, :edit, :destroy]


        def new
            @sport_categories = SportCategorie.new
       
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

                redirect_to({action: :index}, success: 'Vous avez ajouté une nouvelle catégorie de sport !')
            else
                render :new
            end
        end
    
        def update
             if @sport_categories.update(sport_categorie_params)
            

                redirect_to({action: :index}, success: 'La catégorie a bien été modifiée !')
            else
                render :new
            end

        end

        def destroy
            @sport_categories.destroy
            redirect_to({action: :index}, success: 'La catégorie a bien été supprimée !')
        end


        private 

        def sport_categorie_params
            params.require(:sport_categorie).permit(:name, :slug)
    
        end

        def set_sport_categories
            @sport_categories = SportCategorie.find(params[:id])

        end
    end

end