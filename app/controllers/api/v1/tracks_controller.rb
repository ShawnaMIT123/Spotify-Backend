class Api::V1::TracksController < ApplicationController
  skip_before_action :authorized
  before_action :find_track, only: [:show, :index, :destroy, :update]
  def index
    @tracks = Track.all
    render json: @tracks
  end

  def show
    render json: @track
  end

  def update
    @debugger
    render json: @track
  end

def destroy
  @track.destroy
end

  private

  def track_params
    params.permit(:title, :image, :artist, :uri, :id, :img_url, :duration_ms, :start_time)
  end

  def find_track
    @track = Track.find(params[:id])
  end
end
