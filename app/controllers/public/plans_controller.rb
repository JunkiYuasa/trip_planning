class Public::PlansController < ApplicationController
  before_action :authenticate_user!

  def new
    if params[:plan]
      @plan = Plan.new(plan_params)
    else
      @plan = Plan.new
    end
    @plan_genres = PlanGenre.where('standard = ? OR user_id = ?', true, current_user.id)
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      flash[:notice] = "プランを作成しました"
      response.headers['Turbolinks-Location'] = plans_path
      redirect_to plans_path
    else
      @plan_genres = PlanGenre.where('standard = ? OR user_id = ?', true, current_user.id)
      @default_plan_genre = PlanGenre.find_by(name: '未分類')
      @plan.plan_genre_id = @default_plan_genre.id if @default_plan_genre
      render :new
    end
  end

  def show
  end

  def index
    @plans = current_user.plans
    respond_to do |format|
      format.html
      format.json { render 'calendar' }
    end
  end

  def edit
  end

  private

  def plan_params
    params.require(:plan).permit(:plan_genre_id, :name, :address, :post_url, :site_url, :remark, :start_time, :end_time)
  end

end
