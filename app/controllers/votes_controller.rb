class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.user_id = current_user.id
    @vote.voteable_type = params[:type]
    @vote.voteable_id = params[:post]
    if @vote.save
    else
      @togo = Vote.find_by(user_id: current_user.id, voteable_id: params[:post])
      Vote.destroy(@togo.id)
    end
      respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy

  end
end