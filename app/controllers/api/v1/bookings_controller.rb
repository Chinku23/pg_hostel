class Api::V1::BookingsController < ApplicationController
  before_action :set_room, only: [:create]
  before_action :set_booking, only: [:destroy, :approve, :reject] 
  before_action :authorize_admin!, only: [:approve, :reject] 

  def index
    if @current_user.admin?
      @bookings = Booking.all 
    else
      @bookings = @current_user.bookings
    end
    render json: @bookings
  end

  def create
    if @room.present?
      booking = @room.bookings.build(booking_params.merge(user_id: @current_user.id, status: 'pending'))  
      if booking.save
        render json: booking, status: :created
      else
        render json: { errors: booking.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Room not found' }, status: :not_found
    end
  end

  def approve
    if @booking.update(status: 'approved')
      render json: @booking
    else
      render json: { errors: @booking.errors }, status: :unprocessable_entity
    end
  end

  def reject
    if @booking.update(status: 'rejected')
      render json: @booking
    else
      render json: { errors: @booking.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.nil?
      render json: { error: 'Booking not found' }, status: :not_found
      return
    end

    if @current_user.admin? || @booking.user_id == @current_user.id
      if @booking.update(status: 'canceled')
        render json: { message: 'Booking canceled successfully' }, status: :ok
      else
        render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def set_room
    @room = Room.find_by(id: params[:room_id])
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def authorize_admin!
    unless @current_user&.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
