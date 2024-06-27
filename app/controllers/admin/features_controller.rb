class Admin::FeaturesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @feature = Feature.new
    @feature_genres = FeatureGenre.all
    @purposes = Purpose.all
  end

  def create
    @feature = Feature.new(feature_params)
    if @feature.save
      flash[:notice] = "特徴を追加しました"
      redirect_to admin_path
    else
      @feature_genres = FeatureGenre.all
      @purposes = Purpose.all
      render :new
    end
  end

  def edit
    @feature = Feature.find(params[:id])
    @feature_genres = FeatureGenre.all
    @purposes = Purpose.all
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      flash[:notice] = "特徴を変更しました"
      redirect_to admin_path
    else
      @feature_genres = FeatureGenre.all
      @purposes = Purpose.all
      render :edit
    end
  end

  def destroy
    feature = Feature.find(params[:id])
    feature.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to admin_path
  end

  private

  def feature_params
    params.require(:feature).permit(:name, :feature_genre_id, purpose_ids: [])
  end

end
