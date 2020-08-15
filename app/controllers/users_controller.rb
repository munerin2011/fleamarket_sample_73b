class UsersController < ApplicationController

before_action :set_parents, only: [:show, :favorites]

    def new
    end

    def show
      if not request.referrer
        redirect_to root_path
        return
      end
      @user = User.includes(:sending_destination, :profile).find(current_user.id)
    end

    def favorites
      Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
    end

    private
    def redirect_if_signed_out
      redirect_to root_path and return unless request.referrer && user_signed_in?
    end
end
