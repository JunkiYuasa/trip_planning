class Public::PostsController < ApplicationController
  def subject
    @purposes = Purpose.all
  end

  def new
    if params[:purpose_id].present?
      @post = Post.new
      @purpose = Purpose.find(params[:purpose_id])
      @categories = @purpose.categories
      @feature_genres = FeatureGenre.all
      @features = @purpose.features  #subjectで選択した目的idを持つ特徴を表示
    else
      flash[:alert] = "目的を選択してください"
      redirect_to post_subject_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      @purpose = Purpose.find(params[:post][:purpose_id])
      @categories = @purpose.categories
      @feature_genres = FeatureGenre.all
      @features = @purpose.features
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(50)

  #指定の投稿が見つからなかった場合、下記の例外処理を行う
  rescue ActiveRecord::RecordNotFound
    redirect_to not_exist_posts_path
  end

  def edit
    @post = Post.find(params[:id])
    @purpose = @post.purpose
    @categories = @purpose.categories
    @feature_genres = FeatureGenre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を変更しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to user_path(current_user.id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:purpose_id, :category_id, :title, :name, :introduction, :address, :min_fee, :max_fee, :site_url, feature_ids: [], images: [])
  end
end
