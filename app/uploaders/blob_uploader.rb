class BlobUploader < CarrierWave::Uploader::Base
  require 'resolv-replace'
  include CarrierWave::MiniMagick
  include CarrierWave::RMagick

 
  storage :fog
  @name =""
  def initialize(mount,mounter)
    super
    time = Time.new
    @name=Digest::SHA256.hexdigest(time.year.to_s+time.month.to_s+(time.hour*3600+time.min*60+time.sec).to_s)
  end

 
  def store_dir
    "riakbucket/"
  end

  def filename
    #hash of filename
    if !original_filename.nil? 
      if !File.extname(original_filename).blank? and File.extname(@name).blank?
        @name = @name+File.extname(original_filename)
      end
    elsif File.extname(@name).blank?
      @name = @name + '.jpg'
    end

    @name
  end

  def bucket
    "riakbucket"
  end
 
  version :large do
    process resize_to_fit: [400, 400]
    process :crop
  end
 
  version :medium, from_version: :large do
    process resize_to_fit: [500, 500]
  end

  version :small, from_version: :large do
    process resize_to_fit: [160, 160]
  end

  def crop
    manipulate! do |img|
      img.crop!(model.x.to_i,model.y.to_i,model.w.to_i,model.h.to_i,true)
    end
  end
  
end