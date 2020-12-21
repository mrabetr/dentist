class NotesController < ApplicationController
  before_action :find_note, only: [:edit, :update, :destroy]
  before_action :find_booking, only: [:create]

  def create
    @note = Note.new(note_params)
    @note.booking = @booking
    authorize @note

    if @note.save
      redirect_to booking_path(@booking)
    else
      render "booking/show"
    end
  end

  def edit; end

  def update
    if @note.update(note_params)
      redirect_to booking_path(@note.booking)
    else
      render :edit
    end
  end

  def destroy
    @booking = @note.booking
    @note.destroy

    redirect_to booking_path(@booking)
  end

  private

  def find_note
    @note = Note.find(params[:id])
    authorize @note
  end

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

  def note_params
    params.require(:note).permit(:note)
  end
end
