class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user_or_admin!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end

  def followings
    @user = User.find(params[:user_id])
    @word = params[:word]
    if @word.present?
      @heading = "#{@user.name}のフォロー中一覧<br>「#{@word}」の検索結果"
      @users = @user.followings.where("name like ?", "%#{@word}%").order_by_followers.page(params[:page]).per(50)
    else
      @heading = "#{@user.name}のフォロー中一覧"
      @users = @user.followings.order_by_followers.page(params[:page]).per(50)
    end
  end

  def followers
    @user = User.find(params[:user_id])
    @word = params[:word]
    if @word.present?
      @heading = "#{@user.name}のフォワー一覧<br>「#{@word}」の検索結果"
      @users = @user.followers.where("name like ?", "%#{@word}%").order_by_followers.page(params[:page]).per(50)
    else
      @heading = "#{@user.name}のフォロワー一覧"
      @users = @user.followers.order_by_followers.page(params[:page]).per(50)
    end
  end

  # フォローしているユーザーの投稿一覧
  def followings_posts
    followings_ids = current_user.followings.pluck(:id)
    @posts = Post.where(user_id: followings_ids).order(created_at: :desc).page(params[:page]).per(10)
  end


end
