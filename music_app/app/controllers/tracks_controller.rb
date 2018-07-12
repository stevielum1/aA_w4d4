class TracksController < ApplicationController
  before_action :require_user_to_be_logged_in

  def show
    @track = Track.find_by(id: params[:id])

    if @track
      render :show
    else
      flash[:errors] = ["Could not find track"]
      redirect_to bands_url
    end
  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find_by(id: params[:id])

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to edit_track_url(@track)
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])

    if @track.destroy
      redirect_to album_url(@track.album_id)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  private
  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :bonus)
  end

end
