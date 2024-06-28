class Public::PlanGenresController < ApplicationController
  before_action :authenticate_user!

  def new
    @plan_genre = PlanGenre.new
  end

  def create
    @plan_genre = PlanGenre.new(plan_genre_params)
    @plan_genre.user_id = current_user.id
    if @plan_genre.save
      flash[:notice] = "プランジャンルを作成しました"
      redirect_to plan_genres_path
    else
      render :new
    end
  end

  def index
    @plan_genres = PlanGenre.where(standard: true).or(PlanGenre.where(user_id: current_user.id))
  end

  def edit
    plan_genre = PlanGenre.find(params[:id])
    unless plan_genre.user.id == current_user.id
      redirect_to plans_path
    end
    @plan_genre = PlanGenre.find(params[:id])
  end

  def update
    plan_genre = PlanGenre.find(params[:id])
    unless plan_genre.user.id == current_user.id
      redirect_to plans_path
    end
    @plan_genre = PlanGenre.find(params[:id])
    if @plan_genre.update(plan_genre_params)
      flash[:notice] = "プランジャンルを変更しました"
      redirect_to plan_genres_path
    else
      render :edit
    end
  end

  def destroy
    plan_genre = PlanGenre.find(params[:id])
    unless plan_genre.user.id == current_user.id
      redirect_to plans_path
    end
    @plan_genre = PlanGenre.find(params[:id])
    @plan_genre.destroy
    flash[:notice] = "プランジャンルを削除しました"
    redirect_to plan_genres_path
  end

  private

  def plan_genre_params
    params.require(:plan_genre).permit(:name, :color)
  end

end