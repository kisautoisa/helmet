class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @join_groups = current_user.group_users.map{|gu| [gu.group.name, gu.group.id]}
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to group_path(@post.group_id)
    else
      @join_group_selected = post_params[:group_id]
      @join_groups = current_user.group_users.map{|gu| [gu.group.name, gu.group.id]}
      render :new
    end
  end

  def index
    @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new()
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params) if @post.user == current_user
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post.user == current_user
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:group_id, :title, :body, :image).merge(user_id: current_user.id)
  end

end
