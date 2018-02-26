class Gallery < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  before_destroy :clean_gcp

  private

  def clean_gcp
    begin
      image.remove!
      image.thumb.remove!
    rescue Excon::Errors::Error => error
      puts "Something gone wrong"
      false
    end
  end
end
