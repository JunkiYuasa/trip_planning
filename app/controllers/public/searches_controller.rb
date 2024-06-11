class Public::SearchesController < ApplicationController
  def subject
    @purposes = Purpose.all
  end
  
  def condition
    if params[:purpose_id].present?
      @purpose = Purpose.find(params[:purpose_id])
      @categories = @purpose.categories
      @feature_genres = FeatureGenre.all
      @features = @purpose.features 
    else
      flash[:alert] = "目的を選択してください"
      redirect_to search_subject_path
    end
  end
  
  def result
    @posts = Post.all
    
    if params[:category_ids].present?
      category_ids = params[:category_ids].map(&:to_i)
      @posts = @posts.where(category_id: category_ids)
    end
    if params[:name].present?
      @posts = @posts.where('name LIKE ?', "%#{params[:name]}%")
    end    
    if params[:address].present?
      @posts = @posts.where('address LIKE ?', "%#{params[:address]}%")
    end
    if params[:under].present? 
      under = params[:under].to_i
      @posts = @posts.where("min_fee<=?", under)
    end
    if params[:over].present?
      over = params[:over].to_i
      @posts = @posts.where("max_fee>=?", over)
    end
    if params[:feature_ids].present?
      feature_ids = params[:feature_ids].map(&:to_i)
      @posts = @posts.joins(:features).where(features: { id: feature_ids })
                     .group('posts.id')
                     .having('COUNT(features.id) = ?', feature_ids.count)
    end
    
  end
  
end
