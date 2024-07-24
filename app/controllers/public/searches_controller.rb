class Public::SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!

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
    @purpose = Purpose.find(params[:purpose_id])
    @purpose_id = params[:purpose_id].to_i
    @posts = Post.where(purpose_id: @purpose_id)

    # 表示する検索条件のデフォルト
    @conditions = {
      purpose: @purpose.name,
      category_ids: "なし",
      name: "なし",
      address: "なし",
      under: "なし",
      over: "なし",
      feature_ids: "なし"
    }

    # 検索条件が入力されていた場合、それぞれ絞り込みを適応させ、@conditionsの値を変更する
    if params[:category_ids].present?
      # 選択されたカテゴリーのいずれかを持つ投稿を表示
      category_ids = params[:category_ids].map(&:to_i)
      @posts = @posts.where(category_id: category_ids)
      @conditions[:category_ids] = Category.where(id: category_ids).pluck(:name).join(", ")
    end
    if params[:name].present?
      # 施設名にnameが含まれる投稿を表示
      @posts = @posts.where('posts.name LIKE ?', "%#{params[:name]}%")
      @conditions[:name] = params[:name]
    end
    if params[:address].present?
      # 住所にaddressが含まれる投稿を表示
      @posts = @posts.where('address LIKE ?', "%#{params[:address]}%")
      @conditions[:address] = params[:address]
    end
    if params[:over].present?
      # 最高金額がoverよりも高い投稿を表示
      over = params[:over].to_i
      @posts = @posts.where("max_fee>=?", over)
      @conditions[:over] = "#{over}円"
    end

    if params[:under].present?
      # 最低金額がunderよりも低い投稿を表示
      under = params[:under].to_i
      @posts = @posts.where("min_fee<=?", under)
      @conditions[:under] = "#{under}円"
    end
    if params[:post].present?
      # 選択された特徴をすべて含む投稿を表示
      feature_ids = params[:post][:feature_ids].map(&:to_i)
      @posts = Post.where(id: @posts.select { |post| feature_ids.all? { |feature_id| post.features.ids.include?(feature_id) } }.map(&:id))
      @conditions[:feature_ids] = Feature.where(id: feature_ids).pluck(:name).join(", ")
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
