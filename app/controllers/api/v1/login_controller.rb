class Api::V1::LoginController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create


    query_params ={
      client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
      response_type: "code",
      redirect_uri: "http://localhost:3000/api/v1/users",
      scope: "user-top-read user-read-recently-played user-read-email user-read-birthdate user-read-private playlist-read-collaborative playlist-modify-public playlist-read-private playlist-modify-private user-library-modify user-library-read user-follow-read user-follow-modify streaming app-remote-control user-read-playback-state user-modify-playback-state user-read-currently-playing",
      show_dialog: true
    }
      url = "https://accounts.spotify.com/authorize/"


      redirect_to "#{url}?#{query_params.to_query}"


  end

  def show
    byebug
  # If application_controller#authorized is successful,
  render json: {
    # Return JSON data for that current_user
    spotify_id: current_user.spotify_id,
    display_name: current_user.display_name,
    url: current_user.url,
    img_url: current_user.profile_image
    }
end

end
