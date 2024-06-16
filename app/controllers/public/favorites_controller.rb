class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
  def favorite_posts
    # 新しくいいねした投稿を上に表示
    favorite_ids = current_user.favorites.order(created_at: :desc).pluck(:post_id)
    @posts = Post.where(id: favorite_ids).sort_by { |post| favorite_ids.index(post.id) }
  end
end

