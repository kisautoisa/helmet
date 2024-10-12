class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user = User.find(current_user.id).update(user_params)
      redirect_to mypage_path
    else
      render :mypage
    end
  end

  private
  # def user_params
  #   params.require(:user).permit(:name)
  # end
  def set_user
    @user = User.find([:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end

end
