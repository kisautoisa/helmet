class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).toggle!(:is_deleted)
    redirect_to admin_dashboards_path
  end
end
