class PagesController < ApplicationController
  def about
  end

  def home
  	if logged_in?
  		@posts = Post.all
  		#@newPost = current_user.posts.build(:posted_by_id => current_user.u_id, :p_id => )
  	else
  		redirect_to root_url
  	end
  end

  def profile
  	if logged_in?
  		super
  	else
  		redirect_to root_url
  	end
  end

  def explore
  	if logged_in?
  		super
  	else
  		redirect_to root_url
  	end
  end

  def post
  	if logged_in?
  		current_user.post.create(content: params[:post][:content])
  	else
  		redirect_to root_url
  	end
  end

end
