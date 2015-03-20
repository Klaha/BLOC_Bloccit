class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)

    # For not having to use <%= form_for [topic, post, post.comments.new] do |f| %>
    # on comments/_comments.html.erb
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])

    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post

    if @post.save
      @post.create_vote
      flash[:notice] = "Post was Saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was a problem saving your Post. Try again!"
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])

    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])

    authorize @post

    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     title = @post.title
     authorize @post

     if @post.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)    
  end
  
end
