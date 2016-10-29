class BlobUploader < CarrierWave::Uploader::Base
  require 'resolv-replace'
  include CarrierWave::MiniMagick
 
  storage :fog
 
  def store_dir
    "riakbucket/"
  end

  def key
    original_filename
  end

  def bucket
    "riakbucket"
  end
 
  version :large do
    process resize_to_limit: [800, 800]
  end
 
  version :medium, :from_version => :large do
    process resize_to_limit: [500, 500]
  end
 
end