class Public::CommentsController < ApplicationController
  before_action :authenticate_user_or_admin!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントを送信しました"
      redirect_to post_path(@post)
    else
      flash[:alert] = "コメント文を入力してください"
      @comments = @post.comments
      redirect_to post_path(@post)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    unless admin_signed_in?
      unless comment.user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
