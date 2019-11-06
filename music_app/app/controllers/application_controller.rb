class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        return nil if session[:session_token].nil?
        @current_user = User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def log_in_user!(user)
        @current_user = user
        session[:session_token] = user.session_token
    end

    def log_out_user!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
    end

    def require_user_not_signed_in!
        if logged_in?
            flash[:errors] = ["You are already signed in"]
            redirect_to user_url(current_user) 
        end
    end

    def require_user!
        unless logged_in?
            flash[:errors] = ["You need to be signed in to access user's page"]
            redirect_to new_session_url 
        end
    end
end
