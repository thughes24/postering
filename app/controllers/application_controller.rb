class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :restricted, :logged_out_only, :editable, :check_if_starred, :nicetime
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def restricted
    if !logged_in?
      redirect_to root_path
    end
  end

  def logged_out_only
    if logged_in?
      redirect_to posts_path
    end
  end

  def editable(post)
    post.user_id == session[:user_id] || session[:user_id] == 3 #admins user id
  end

  def set_all_categories_for_navbar
    @categories = Category.all
  end
  def check_if_starred(voted_object)
    exists = Vote.where(user_id: session[:user_id]).find_each
    if !exists.nil?
      exists.each do |star|
        return true if star.voteable_id == voted_object.id
      end
    end
  end

  def nicetime(timestring)
    timestring.strftime("%D at %r")
  end
end
