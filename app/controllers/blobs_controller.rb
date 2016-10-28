class BlobsController < ApplicationController
  #before_action :set_blob, only: [:show, :edit, :update, :destroy]
 
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
    @blob = Blob.new(post_blob_params)
 
    if @blob.save
      redirect_to @blob, notice: 'Blob was successfully created.'
    else
      render :new
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
      params.require(:blob).permit(:med_id, :content)
    end
end