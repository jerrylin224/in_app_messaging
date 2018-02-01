class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [300, 300]
    process :add_text

    # (image.columns / mark.columns.to_f).ceil.times do |x|
    #   (image.rows / mark.rows.to_f).ceil.times do |y|
    #     tile << mark.dup
    #     page.x = x * tile.columns
    #     page.y = y * tile.rows
    #     tile.page = page
    #   end
    # end

    def add_text
      watermark = "此文件僅供台北直接貸內部使用"

      manipulate! do |image|
        image.combine_options do |c|
          c.gravity 'Center'
          c.pointsize '12'
          c.font "#{Rails.root}/public/microsoft_font.ttf" 
          c.draw "text 0,0 '#{watermark}'"
          c.fill 'white'
        end
        image
      end    
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
