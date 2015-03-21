class FavoritesController < ApplicationController
  def create
   @post = Post.find(params[:post_id])
   favorite = current_user.favorites.build(post: @post)
   authorize favorite

   if favorite.save
      flash[:notice] = "Post Favorited"
      redirect_to [@post.topic, @post]
   else
      flash[:error] = "Oops... there was a problem favoriting this"
      redirect_to @post
   end
  end

  def destroy
   @post = Post.find(params[:post_id])
   favorite = current_user.favorites.find(params[:id])
   authorize favorite
   
   if favorite.destroy
     flash[:notice] = "Post UN-Favorited"
     redirect_to [@post.topic, @post]
   else
     flash[:error] = "Oops... there was a problem UN-favoriting this"
     redirect_to @post
   end
  end

end
