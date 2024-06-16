class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
    @purposes = Purpose.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリーを追加しました"
      redirect_to admin_path
    else
      @purposes = Purpose.new
      render :new
    end
  end
    
  def edit
    @category = Category.find(params[:id])
    @purposes = Purpose.all
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリーを変更しました"
      redirect_to admin_path
    else
      @purposes = Purpose.all
      render :edit
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to admin_path
  end
  
  private
  
  def category_params
    params.require(:category).permit(:purpose_id, :name)
  end
  
end

