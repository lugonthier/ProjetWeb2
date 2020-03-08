module Admin
    class SportsController < ApplicationController

        before_action :set_sport, only: [ :destroy, :show]



        
        def index
            @sports = Sport.all
        end

        def show
            @sport = Sport.find(params[:id])
        end

        

        def destroy
            @sport.destroy

            redirect_to( admin_sports_path, success: "le post a été supprimé")

        end

        private
        def set_sport
            @sport = Sport.find(params[:id])

        end


    end
end