class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @purposes = Purpose.all
    @feature_genres = FeatureGenre.all
    @categories = Category.all
    @features = Feature.all
    @title = "HOME（すべて）"

    if params[:purpose_id].present?
      @purpose = Purpose.find(params[:purpose_id])
      @categories = @purpose.categories
      @title = "HOME（#{@purpose.name}）"
    end
  end
end
