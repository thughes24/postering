class WelcomeController < ApplicationController
  before_action :logged_out_only
  def index
    @user = User.new
  end
end