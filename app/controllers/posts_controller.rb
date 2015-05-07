class PostsController < ApplicationController
  before_action :restricted
  before_action :set_all_categories_for_navbar, only: [:index,:new,:edit,:create,:update]
  before_action :set_post_var, only: [:edit, :update]
  def index 
    @posts = Post.all
    @comment = Comment.new
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Updated Successfully"
      redirect_to posts_path(anchor: @post.title)
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title,:contents,:user_id, category_ids: [])
  end

  def set_post_var
    @post = Post.find(params[:id])
  end
end