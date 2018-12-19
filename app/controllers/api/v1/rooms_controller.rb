class Api::V1::RoomsController < ApplicationController
  before_action :find_room, only: [:update]
  def index
    @rooms = Room.all
    render json: @rooms
  end

  def show

    render json: @room
  end

  def update


    
    track = Track.new(room_id: @room.id, spotify_url: room_params["uri"], title: room_params["title"], artist: room_params["artist"], img_url: room_params["image"])
    if track.save
      render json: @room, status: :accepted
    else
      render json: { errors: @room.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def room_params
    params.permit(:title, :image, :artist, :uri, :id, :img_url, :duration_ms)
  end

  def find_room
    @room = Room.find(params[:id])
  end
end
