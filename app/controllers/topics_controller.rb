class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic

    if @topic.save
      flash[:notice] = "Topic was Created."
      redirect_to @topic
    else
      flash[:error] = "There was a problem creating the Topic. Try again!"
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
    
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic

    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the Topic. Please try again."
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).authorize(:name, :description, :public)
  end

end
