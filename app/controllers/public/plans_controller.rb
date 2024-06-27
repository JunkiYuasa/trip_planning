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
      redirect_to plan_path(@plan)
    else
      @plan_genres = PlanGenre.where('standard = ? OR user_id = ?', true, current_user.id)
      @default_plan_genre = PlanGenre.find_by(name: '未分類')
      @plan.plan_genre_id = @default_plan_genre.id if @default_plan_genre
      render :new
    end
  end

  def index
    @plans = current_user.plans
    respond_to do |format|
      format.html
      format.json { render 'calendar' }
    end
  end

  def show
    plan = Plan.find(params[:id])
    unless plan.user.id == current_user.id
      redirect_to plans_path
    end
    @plan = Plan.find(params[:id])
  end

  def edit
    plan = Plan.find(params[:id])
    unless plan.user.id == current_user.id
      redirect_to plans_path
    end
    @plan = Plan.find(params[:id])
    @plan_genres = PlanGenre.where('standard = ? OR user_id = ?', true, current_user.id)
  end

  def update
    plan = Plan.find(params[:id])
    unless plan.user.id == current_user.id
      redirect_to plans_path
    end
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      flash[:notice] = "プランを変更しました"
      redirect_to plan_path(@plan)
    else
      @plan_genres = PlanGenre.where('standard = ? OR user_id = ?', true, current_user.id)
      render :edit
    end
  end

  def destroy
    plan = Plan.find(params[:id])
    unless plan.user.id == current_user.id
      redirect_to plans_path
    end
    @plan = Plan.find(params[:id])
    @plan.destroy
    flash[:notice] = "プランを削除しました"
    redirect_to plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:plan_genre_id, :name, :address, :post_url, :site_url, :remark, :start_time, :end_time)
  end

end
