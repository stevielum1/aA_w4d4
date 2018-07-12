class NotesController < ApplicationController
  before_action :current_user_must_be_author, only: [:destroy]

  def create
    @note = Note.new(note_params)
    @note.author_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])

    if @note.destroy
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  private
  def note_params
    params.require(:note).permit(:track_id, :description)
  end

  def current_user_must_be_author
    current_user_notes = current_user.notes
    note = current_user_notes.find_by(id: params[:id])
    unless note
      render text: 'You cannot delete this note because you are not the author', status: 403
    end
  end
end
