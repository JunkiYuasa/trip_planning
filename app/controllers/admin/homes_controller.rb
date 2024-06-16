class Admin::HomesController < ApplicationController
  def top
    @purposes = Purpose.all
    @categories = Category.all
    @feature_genres = FeatureGenre.all
    @features = Feature.all
  end
end
