class Public::PostsController < ApplicationController
  before_action :authenticate_user_or_admin!

  def subject
    @purposes = Purpose.all
  end

  def new
    if params[:purpose_id].present?
      @post = Post.new
      @purpose = Purpose.find(params[:purpose_id])
      set_attributes_data
    else
      flash[:alert] = "目的を選択してください"
      redirect_to subject_posts_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      if @post.save
        @post.images.each_with_index do |image, index|
          # 一時ファイルを作成し、画像データを書き込む
          tempfile = Tempfile.new(["image_#{index}", image.filename.extension_with_delimiter])
          tempfile.binmode
          tempfile.write(image.blob.download)
          tempfile.rewind
          # ActionDispatch::Http::UploadedFileオブジェクトを作成
          uploaded_file = ActionDispatch::Http::UploadedFile.new(
            tempfile: tempfile,
            filename: image.filename.to_s,
            type: image.content_type,
            head: nil
          )
          # Vision APIを使用して画像からタグを取得
          tags = Vision.get_image_data(uploaded_file)
          tags.each do |tag|
            # タグを作成
            created_tag = Tag.find_or_create_by(name: tag)
            # タグと画像の関連を作成
            PostTag.create(post_id: @post.id, tag_id: created_tag.id, image_key: image.blob.key)
          end
          # 一時ファイルを閉じて消去
          tempfile.close
          tempfile.unlink
        end
        flash[:notice] = "投稿しました"
        redirect_to post_path(@post)
      else
        @purpose = Purpose.find(params[:post][:purpose_id])
        set_attributes_data
        render :new
      end

  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @image_tags = @post.images.each_with_object({}) do |image, hash|
      hash[image.blob.key] = Tag.joins(:post_tags).where(post_tags: { image_key: image.blob.key })
    end
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(50)

  #指定の投稿が見つからなかった場合、下記の例外処理を行う(主にスケジュールのプランから削除されているリンクに飛んだ場合)
  rescue ActiveRecord::RecordNotFound
    redirect_to not_exist_posts_path
  end

  def edit
    post = Post.find(params[:id])
    unless admin_signed_in?
      unless post.user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @post = Post.find(params[:id])
    @purpose = @post.purpose
    set_attributes_data
  end

  def update
    post = Post.find(params[:id])
    unless admin_signed_in?
      unless post.user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を変更しました"
      redirect_to post_path(@post)
    else
      @purpose = Purpose.find(params[:post][:purpose_id])
      set_attributes_data
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    unless admin_signed_in?
      unless post.user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private

  def set_attributes_data
    @categories = @purpose.categories
    @feature_genres = FeatureGenre.all
    @features = @purpose.features
  end

  def post_params
    params.require(:post).permit(:purpose_id, :category_id, :title, :name, :introduction, :address, :min_fee, :max_fee, :site_url, feature_ids: [], images: [])
  end
end