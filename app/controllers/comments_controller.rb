class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post

    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
 
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      # redirect_to [@post.topic, @post] > So we can use AJAX.
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      # redirect_to [@post.topic, @post] > So we can use AJAX.
    end

    respond_to do |format|
      format.html
      format.js
    end
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end