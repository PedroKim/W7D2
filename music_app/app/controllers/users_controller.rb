class UsersController < ApplicationController
    before_action :require_user_not_signed_in!, only: [:new, :create]
    before_action :require_user!, only: :show

    def show
        @user = current_user
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:success] = "Successfully Signed Up"
            log_in_user!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages

            render :new, status: 422
        end

    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end