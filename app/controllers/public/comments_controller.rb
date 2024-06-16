class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    flash[:notice] = "コメントを送信しました"
    redirect_to post_path(post)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
