class UsersController < ApplicationController
  before_action :restricted, except: [:create,:login,:new]
  before_action :set_all_categories_for_navbar, only: [:show, :edit]
  before_action :is_same_user, only: :edit
  
  def index
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      flash[:error] = "Invalid Username/Password"
      redirect_to root_path(which_form: 'login')
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Registered Successfully"
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render '/welcome/index'
    end
  end

  def show
    @user = User.find_by(slug: params[:id])
    @comment = Comment.new
  end

  def edit
    @user = User.find_by(slug: params[:id])
  end

  def update
    @user = User.find_by(slug: params[:id])
    @user.update(params.require(:user).permit(:username, :email, :timezone))
    redirect_to edit_user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit!
  end

  def is_same_user
    if !(current_user.id == User.find_by(slug: params[:id]).id)
      flash[:notice] = "That aint your account to edit m8"
      redirect_to posts_path 
    end
  end
end