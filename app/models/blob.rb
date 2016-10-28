class Blob < ActiveRecord::Base
   mount_uploader :med_id, BlobUploader
end