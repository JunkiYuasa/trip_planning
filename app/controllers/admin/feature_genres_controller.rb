class Admin::FeatureGenresController < ApplicationController
  def new
    @feature_genre = FeatureGenre.new
  end
  
  def create
    @feature_genre = FeatureGenre.new(feature_genre_params)
    if @feature_genre.save
      flash[:notice] = "特徴ジャンルを追加しました"
      redirect_to admin_path
    else
      render :new
    end
  end
    
  def edit
    @feature_genre = FeatureGenre.find(params[:id])
  end
  
  def update
    @feature_genre = FeatureGenre.find(params[:id])
    if @feature_genre.update(feature_genre_params)
      flash[:notice] = "特徴ジャンルを変更しました"
      redirect_to admin_path
    else
      render :edit
    end
  end
  
  def destroy
    feature_genre = FeatureGenre.find(params[:id])
    feature_genre.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to admin_path
  end
  
  private
  
  def feature_genre_params
    params.require(:feature_genre).permit(:name)
  end
  
end
