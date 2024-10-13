class Public::GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @user = GroupUser.user?(current_user, params[:id])
    @users = @group.group_users
    @admins = @users.where(is_admin: true)
    pp '---------------'
    pp @admins
  end

  def create
    ActiveRecord::Base.transaction do
      @group = Group.new(group_params)
      if @group.save
        if @group.group_users.new(user_id: current_user.id, is_admin: true).save
          redirect_to group_path(@group)
        end
      else
        render :new
      end
    end
  end

  def edit
     @group = Group.find(params[:id])
     redirect_to group_path(@group) unless GroupUser.is_admin?(current_user)
  end

  def update
    @group = Group.find(params[:id])
    redirect_to group_path(@group) unless GroupUser.is_admin?(current_user)

    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def change_join
    group = GroupUser.user?(current_user.id, params[:group_id])
    if group.present?
      group.destroy unless group.is_admin
    else
      GroupUser.new(user_id: current_user.id, group_id: params[:group_id]).save
    end

    redirect_to group_path(params[:group_id])
  end

  def change_admin
    GroupUser.user?(params[:user_id], params[:group_id]).toggle!(:is_admin)
    redirect_to group_path(params[:group_id])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

end
