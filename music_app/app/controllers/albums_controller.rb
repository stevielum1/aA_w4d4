class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render :index
  end

  def show
    @album = Album.find_by(id: params[:id])

    if @album
      render :show
    else
      flash[:errors] = ["Could not find album"]
      redirect_to bands_url
    end
  end

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Could not create album"]
      redirect_to new_band_album_url(@album.band_id)
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find_by(id: params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Could not update album"]
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])

    if @album.destroy
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] = ["Could not delete album"]
      redirect_to album_url(@album)
    end
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title, :year, :studio)
  end
end
