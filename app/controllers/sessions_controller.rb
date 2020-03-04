class SessionsController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]


  def new
  end

  def create
    user_params = params.require(:user)

    @user = User.where('confirmed = 1 AND (username = :username OR email = :username)', username: user_params[:username]).first
    if @user and  @user.authenticate(user_params[:password]) and User.where(confirmed: true)
    
      session[:auth] = @user.to_session
      redirect_to sports_path, success: 'Connexion réussie'
    else

      redirect_to new_session_path, danger: 'Identifiants incorrects.'
      
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: 'Vous êtes déconnecté.'
  end
end
