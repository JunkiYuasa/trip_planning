class Public::UsersController < ApplicationController
  before_action :authenticate_user_or_admin!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def index
    @word = params[:word]
    if @word.present?
      @heading = "ユーザー一覧<br>「#{@word}」の検索結果"
      @users = User.where("name like ?", "%#{@word}%").order_by_followers.page(params[:page]).per(30)
    else
      @heading = "ユーザー一覧"
      @users = User.order_by_followers.page(params[:page]).per(30)
    end
  end

  def edit
    user = User.find(params[:id])
    unless admin_signed_in?
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    unless admin_signed_in?
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user_path(user)
    else
      render :edit
    end
  end

  def withdrawal
    user = User.find(params[:id])
    unless admin_signed_in?
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    unless admin_signed_in?
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash[:alert] = "ゲストユーザーはプロフィール編集ができません"
      redirect_to user_path(current_user)
    end
  end

end
