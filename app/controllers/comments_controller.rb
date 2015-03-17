class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    authorize @comment
    
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

end