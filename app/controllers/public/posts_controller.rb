class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @posts = Post.looks(params[:search], params[:word])
  end

  def show
    @post = Post.find(params[:id])
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
    params.require(:post).permit(:title, :body, :image).merge(user_id: current_user.id)
  end

end
