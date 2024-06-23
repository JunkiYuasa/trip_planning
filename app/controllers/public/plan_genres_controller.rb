class Public::PlanGenresController < ApplicationController
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
    @plan_genres = PlanGenre.all
    # @plan_genres = PlanGenre.where(standard: true).or(PlanGenre.where(user_id: current_user.id))
  end

  def edit
  end

  private

  def plan_genre_params
    params.require(:plan_genre).permit(:name, :color)
  end

end