class PagesController < ApplicationController
 

  def home
  	if logged_in?
      @user = current_user
      @blob = Blob.new
      @images = Blob.all
  	  @posts = Post.where("posts.parent_id is NULL and posts.posted_by_id != ?", current_user.u_id)
      @newPost = current_user.own_posts.build # Post.new and set Post.posted_by_id= current_user.u_id
  	else
  		redirect_to root_url
  	end
  end
end
