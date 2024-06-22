class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def index
    @word = params[:word]
    if @word.present?
      @heading = "ユーザー一覧<br>「#{@word}」の検索結果"
      @users = User.where("name like ?", "%#{@word}%")
    else
      @heading = "ユーザー一覧"
      @users = User.all
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to user_path(user)
    else
      render :edit
    end
  end

  def withdrawal
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to root_path
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
