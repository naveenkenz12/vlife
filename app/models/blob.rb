class Blob < ActiveRecord::Base
   attr_accessor :x, :y,:w, :h
   mount_uploader :med_id, BlobUploader
end