class BlobUploader < CarrierWave::Uploader::Base
  require 'resolv-replace'
  include CarrierWave::MiniMagick
  include CarrierWave::RMagick

 
  storage :fog
  @name =""
  def initialize(mount,mounter)
    super
    time = Time.new
    temp=nil
    if !original_filename.nil?
      temp=original_filename;
    else
      temp="asdasdxvsdf";
    end

    @name=Digest::SHA256.hexdigest(temp+time.year.to_s+time.month.to_s+(time.hour*3600+time.min*60).to_s+"zcbhsuhdf")
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
    process resize_to_limit: [800, 800]
    process :crop
    process resize_to_fit: [500, 500]
  end
 
  version :medium , from_version: :large do
    process resize_to_limit: [160, 160]
  end

  version :small , from_version: :large do
    process resize_to_limit: [80, 80]
  end

  version :xsmall , from_version: :large do
    process resize_to_limit: [40, 40]
  end

  version :group , from_version: :large do
    process resize_to_fit: [825, 350]
  end

  version :sgroup , from_version: :large do
    process resize_to_fit: [140, 60]
  end

  def crop
    manipulate! do |img|
      img.crop!(model.x.to_i,model.y.to_i,model.w.to_i,model.h.to_i,true)
    end

  end
  
end