class UsersController < ApplicationController
  before_action :restricted, except: [:create,:login,:new]
  before_action :set_all_categories_for_navbar, only: :show
  
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
    @user = User.find(params[:id])
    @comment = Comment.new
  end


  private
  def user_params
    params.require(:user).permit!
  end
end