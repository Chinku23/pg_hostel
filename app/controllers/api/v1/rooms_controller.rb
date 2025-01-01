class Api::V1::RoomsController < ApplicationController
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  before_action :set_hostel, only: [:index, :create]
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    rooms = @hostel.rooms
    render json: rooms
  end

  def create
    room = @hostel.rooms.build(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { errors: room.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: { errors: @room.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      render json: { message: 'Room deleted successfully' }, status: :ok
    else
      render json: { errors: @room.errors }, status: :unprocessable_entity
    end
  end

  def search
    rooms = Room.all
    rooms = rooms.where('capacity >= ?', params[:capacity]) if params[:capacity].present?
    rooms = rooms.where('price <= ?', params[:price]) if params[:price].present?
    rooms = rooms.where(availability: params[:availability]) if params[:availability].present?
    render json: rooms, status: :ok
  end

  private

  def set_hostel
    @hostel = Hostel.find(params[:hostel_id])
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_admin!
    unless @current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def room_params
    params.require(:room).permit(:room_type, :availability, :capacity, :price, :description)
  end
end
