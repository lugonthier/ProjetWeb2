module Admin
    class UsersController < ApplicationController
        before_action :set_user, only: [ :destroy]



        # L'admin ne peut que supprimer un utilisateur, il n'est pas en droit de modifier un compte.
        
        
        def index
            @users = User.all
        end

        

        def destroy
            @user.destroy

            redirect_to( admin_users_path, success: "le compte a été supprimé")

        end

        private
        def set_user
            @user = User.find(params[:id])

        end

        
    end
end