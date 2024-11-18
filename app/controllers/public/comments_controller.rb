class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      @post = Post.find(@comment.post_id)
      render 'public/posts/show'
    end
  end

  def destroy
    comment = Post.find(params[:post_id]).comments.find(params[:id])
    comment.destroy if comment.user == current_user
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
