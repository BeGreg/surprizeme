class UsersController < ApplicationController
  before_action :load_user, only: [:show, :update]
 def new
  end

  def show
  end

  def edit
  end

  def index
  end

  def update
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :mobile_phone)
  end

    def load_user
    @user = User.find(params[:id])
  end
end
