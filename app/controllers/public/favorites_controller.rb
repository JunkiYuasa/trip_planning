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
    order_clause = favorite_ids.map.with_index { |id, index| "WHEN #{id} THEN #{index}" }.join(' ')
    @posts = Post.where(id: favorite_ids).order(Arel.sql("CASE id #{order_clause} END")).page(params[:page]).per(10)
  end
end

