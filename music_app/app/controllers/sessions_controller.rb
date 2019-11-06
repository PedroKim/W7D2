class SessionsController < ApplicationController
    before_action :require_user_not_signed_in!, only: [:new, :create]

    def new
        @user = User.new

        render :new
    end
    
    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if @user.nil?
            @user = User.new(email: params[:user][:email])
            flash.now[:errors] = ["Email/Password does not match"]
            render :new, status: 422
        else
            flash[:success] = "Successfully Signed In"
            log_in_user!(@user)
            redirect_to user_url(@user)
        end
    end

    def destroy
        log_out_user!
        redirect_to new_session_url
    end

end