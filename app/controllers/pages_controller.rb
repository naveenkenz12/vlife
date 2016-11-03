class PagesController < ApplicationController
 

  def home
  	if logged_in?
      @userprofile = UserProfile.find_by(:u_id => current_user.u_id)
      @dp = nil
      if !@userprofile.blank?
        @dp = Blob.find_by(med_id: @userprofile.profile_pic)
      end

      @user = current_user
      @images = Blob.all
      @blob = Blob.new
  	  @posts = Post.where("posts.parent_id is NULL and posts.posted_by_id != ?", current_user.u_id)
      @newPost = current_user.own_posts.build # Post.new and set Post.posted_by_id= current_user.u_id
  	else
  		redirect_to root_url
  	end
  end
end
