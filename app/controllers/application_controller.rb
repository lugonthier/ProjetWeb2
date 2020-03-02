class ApplicationController < ActionController::Base

    before_action :only_signed_in
    add_flash_types :success, :danger
    helper_method :current_user, :is_user_signed_in




    private

    def only_signed_in
        if !is_user_signed_in
            redirect_to new_user_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
        end
    end

    #Seulement accessible pour les personnes non connecté.
    def only_signed_out
        redirect_to profil_path if is_user_signed_in

    end

    # Retourne l'utilisateur actuellement connecté.
    def current_user
        return nil if !session[:auth] || !session[:auth]['id']
        return @_user if @_user
        @_user = User.find_by_id(session[:auth]['id'])
    end

    # Pour savoir si l'utilisateur est connecté.
    def is_user_signed_in
        !current_user.nil?
    end
end
