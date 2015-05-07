class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:success] = "Comment Posted Successfully"
      redirect_to posts_path(postcomments: "#{@comment.post.id}", anchor: "#{@comment.post.title}")
    else
        flash[:error] = "Comment cannot be Blank"
        redirect_to posts_path
    end
  end

  def edit

  end

  def update

  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end