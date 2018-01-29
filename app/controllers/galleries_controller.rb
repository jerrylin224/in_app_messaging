class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.all
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      redirect_to galleries_path
    end
  end

  def new
    @gallery = Gallery.new
  end

  private
    def gallery_params
      params.require(:gallery).permit!
    end
end