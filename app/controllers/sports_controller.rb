class SportsController < ApplicationController
    before_action :set_sport, only: [:show, :edit, :update]
    skip_before_action :only_signed_in, only:[:show]

    def show
        @sport = Sport.find(params[:id])
    end

    def index
        @sports = current_user.sports
    end

    def new
        @sport = current_user.sports.new
    end
    
    def create
        @sport = current_user.sports.new(sport_params)

        if @sport.save

            redirect_to sports_path, success: 'Vous avez ajouté votre nouveau sport !'
        else
            render :new
        end
    
    end

    def edit
    
    end

    def update
        if @sport.update(sport_params)
            redirect_to sports_path, success: 'Votre sport a bien été modifié'
        else
            render :edit
        end
    end

    def destroy
        

        @sport = Sport.find(params[:id])
        if @sport.present?
            @sport.destroy
        end
        redirect_to sports_path, success: 'Votre sport a bien été supprimé'

    end

    private
    def sport_params
        params.require(:sport).permit(:name, :date_begin, :frequence, :sport_categorie_id, :photo_file)
    
    end

    def set_sport
        
       @sport = current_user.sports.find(params[:id])

    end

     
    
end