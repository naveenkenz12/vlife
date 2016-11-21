class BlobsController < ApplicationController
  before_action  :logged_in_user, only: [:show, :edit, :update, :destroy]
  

  # GET /blobs
  def index
    @blobs = Blob.all
  end
 
  # GET /blobs/1
  def show
  end
 
  # GET /blobs/new
  def new
    @blob = Blob.new
  end
 
  # GET /blobs/1/edit
  def edit
  end
 
  # POST /blobs
  def create
    p params[:blob][:x]
    p params[:blob][:y]
    p params[:blob][:w]
    p params[:blob][:h]
    
    @blob = Blob.new(post_blob_params.except(:med_id))
    @blob.med_id = params[:blob][:med_id];

    
    # default if error
    msg = {:status => "Error ! Please Try Again"}
    error= true;
    
    p @blob.med_id.filename
    #if profile picture
    if @blob.content=="profile_pic"
      @userprofile = UserProfile.find(current_user.u_id)
    
      if !@userprofile.blank?
        Blob.transaction do
          if @blob.save
            @userprofile.update(profile_pic: @blob.med_id.filename)
            error=false
            @post_entry=Post.new
            @post_entry.p_id = Post.count.to_s(36)
            @content = "Changed profile picture"
            @post_entry.content = @content
            @post_entry.posted_by_id = current_user.u_id
            @post_entry.media_id = @blob.med_id.filename
            @post_entry.save
            ##render :json => @blob.as_json
            redirect_to :back
          end
        end
      end
    elsif @blob.content=="page_pic"
      @grp = GroupPage.find_by(:page_id => params[:blob][:page_id])
      @gru = GroupUser.find_by(:page_id => params[:blob][:page_id], :u_id => current_user.u_id)

      if !@gru.blank?
        Blob.transaction do
          if @blob.save
            # update profile_pic column in user_profiles
            @grp.update(page_pic: @blob.med_id.filename)
            error=false
            
            redirect_to :back
          end
        end
      end
    elsif @blob.content=="post_pic"
      #if post
    elsif @blob.content =="album_pic"
      #if album      
    end


    if error
      flash[:notice] = "Error!, try again"
      
      render :json => msg
    end
  end
 
  # PATCH/PUT /blobs/1
  def update
    if @blob.update(post_blob_params)
      redirect_to @blob, notice: 'Blob attachment was successfully updated.'
    else
      render :edit
    end
  end
 
  # DELETE /blobs/1
  def destroy
    @blob.destroy
    redirect_to blobs_url, notice: 'Blob was successfully destroyed.'
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blob
      @blob = Blob.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_blob_params
      params.require(:blob).permit(:med_id, :content,:x,:y,:w,:h)
    end
end