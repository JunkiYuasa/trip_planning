class Admin::HomesController < ApplicationController
  def top
    @purposes = Purpose.all
    @feature_genres = FeatureGenre.all
    @categories = Category.all
    @features = Feature.all

    if params[:purpose_id].present?
    @purpose = Purpose.find(params[:purpose_id])
    @categories = @purpose.categories
    end
  end
end
