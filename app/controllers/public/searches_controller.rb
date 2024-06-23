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
      redirect_to subject_posts_path
    end
  end

  def result
    purpose_id = params[:purpose_id].to_i
    @posts = Post.where(purpose_id: purpose_id)

    # 検索条件が入力されていた場合、それぞれ絞り込みを適応させる
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

    # 直近30日間のfavorite作成数>全期間のfavorite作成数>post作成日時で並び替え
    start_date = 30.days.ago.strftime("%Y-%m-%d %H:%M:%S")  # SQLエラーが発生するため、日付を直接文字列に変換
    @posts = @posts.left_joins(:favorites)
                   .select("posts.*, COUNT(CASE WHEN favorites.created_at >= '#{start_date}' THEN 1 END) AS recent_favorites_count, COUNT(favorites.id) AS total_favorites_count")
                   .group('posts.id')
                   .order('recent_favorites_count DESC, total_favorites_count DESC, posts.created_at DESC')
                   .page(params[:page]).per(20)
  end

end
