class Gallery < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
