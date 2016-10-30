class BlobUploader < CarrierWave::Uploader::Base
  require 'resolv-replace'
  include CarrierWave::MiniMagick
 
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
    if !File.extname(original_filename).blank? and File.extname(@name).blank?
      @name = @name+File.extname(original_filename)
    end
    @name
  end

  def bucket
    "riakbucket"
  end
 
  version :large do
    process resize_to_limit: [500, 500]
  end
 
  version :medium do
    process resize_to_limit: [160, 160]
  end

  version :small do
    process resize_to_limit: [80, 80]
  end

  version :xsmall do
    process resize_to_limit: [40, 40]
  end
  
 
end