class CategoriesController < ApplicationController
  before_action :set_all_categories_for_navbar
  def show
    @category = Category.find(params[:id])
    @comment = Comment.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    
    if @category.save
      flash[:notice] = "Category created successfully"
      redirect_to posts_path
    else
      render :new
    end
  end
end