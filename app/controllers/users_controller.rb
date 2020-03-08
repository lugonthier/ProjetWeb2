class UsersController < ApplicationController

    skip_before_action :only_signed_in, only: [:new, :create, :confirm]

   
    def show
        @user = User.find(params[:id])
        @followers = @user.following_users
        @followees = @user.followed_users
    
    end
    
    def new
        @user = User.new
    end

    def create
        user_params = params.require(:user).permit(:username, :email, :lastname, :firstname, :password, :password_confirmation)
        @user = User.new(user_params)
    
        if @user.valid?

            @user.save

            UserMailer.confirm(@user).deliver_now 

            redirect_to new_user_path, success: 'votre compte a bien été crée, vous avez reçu un email de confirmation'

            
            

        else

            render 'new'
        end
    end


    # Pour la confirmation de mail 
    def confirm
        @user = User.find(params[:id])

        if @user.confirmation_token == params[:token]

            @user.update_attributes(confirmed: true, confirmation_token: nil)

            @user.save(validate: false)

            session[:auth] = @user.to_session

            redirect_to profil_path, success: 'votre compte a bien été confirmé'

        else
            redirect_to new_user_path, danger: 'lien (token) non valide'
        end
    end

    def edit
        @user = current_user

    end

    def update
        @user = current_user
        user_params = params.require(:user).permit(:username, :firstname, :lastname, :email, :sport, :photo_file, :description)
        if @user.update(user_params)
            redirect_to profil_path, success: 'Votre compte a bien été modifié'
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path, success: 'Votre compte a bien été supprimé.'
    end


end