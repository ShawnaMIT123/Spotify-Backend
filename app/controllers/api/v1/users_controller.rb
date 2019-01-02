class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  # before_action :find_user, only: [:show]

def index

   @users = User.all.select { |user|  user.online_now == true  }.map{ |user| [user.profile_image, user.display_name]}
   render json: {
     # Return JSON data for that current_user
     users: @users

  }
end

  def show

     current_user.refresh_token


    # if @user.access_token_expired?
    #   body ={
    #     grant_type: "refresh_token",
    #     refresh_token: @user.refresh_token,
    #     client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
    #     client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'
    #
    #   }
    #   auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    #   auth_params = JSON.parse(auth_response)
    #   @user.update(access_token: auth_params["access_token"])
    # else
    #   puts "Current user's acces token has not expired"
    # end





    render json: {
      # Return JSON data for that current_user
      user: {
      spotify_url: current_user.spotify_url,
      username: current_user.username,
      display_name: current_user.display_name,
      uri: current_user.uri,
      profile_image: current_user.profile_image,
      access_token: current_user.access_token,
      user_id: current_user.id
      }
    }
  end

  def create
    if params[:error]
      puts "LOGIN ERROR", params
      redirect_to "http://localhost:3001/login/failure"
    else


      body = {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: "http://localhost:3000/api/v1/users",
        client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
        client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'
      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)


      auth_params = JSON.parse(auth_response.body)

      header = {
        Authorization: "Bearer #{auth_params["access_token"]}"
      }

      user_response = RestClient.get("https://api.spotify.com/v1/me", header)

      user_params = JSON.parse(user_response.body)



      @user = User.find_or_create_by(username: user_params["id"],
      spotify_url: user_params["external_urls"]["spotify"],
      href: user_params["href"], uri:user_params["uri"])

      display_name = user_params['display_name']
      img_url = user_params["images"][0] ? user_params["images"][0]["url"] : nil
  @user.update(profile_image: img_url, display_name: display_name)
  @user.update(online_now: true)


      @user.update(access_token: auth_params["access_token"], refresh_token: auth_params["refresh_token"])
      payload = {user_id: @user.id}
      token = issue_token(payload)



      # redirect_to "http://localhost:3001/success"
      redirect_to "http://localhost:3001/success?jwt=#{token}"
    end
  end

  def addPlaylist

    current_user = User.find(1)
    if current_user.access_token_expired?
      body ={
        grant_type: "refresh_token",
        refresh_token: current_user.refresh_token,
        client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
        client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'

      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's acces token has not expired"
    end

    header = {
      Authorization: "Bearer #{current_user.access_token}",
      "Content-Type": "application/json"
    }
    body = {
      name: "My Playlist Test"
    }



    auth_response = RestClient::Request.execute(method: :post, url: "https://api.spotify.com/v1/users/#{current_user.username}/playlists",
                            payload: {
                              name: params["_json"]
                            }.to_json , headers: {Authorization: "Bearer #{current_user.access_token}",
                            "Content-Type": "application/json"})

  end

  def addSongToPlaylist
    current_user = User.find(1)
    if current_user.access_token_expired?
      body ={
        grant_type: "refresh_token",
        refresh_token: current_user.refresh_token,
        client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
        client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'

      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's acces token has not expired"
    end

    header = {
      Authorization: "Bearer #{current_user.access_token}",
      "Content-Type": "application/json"
    }
    body = {
      name: "My Playlist Test"
    }



    auth_response = RestClient::Request.execute(method: :post, url: "https://api.spotify.com/v1/users/#{current_user.username}/playlists",
                            payload: {
                              name: params["_json"]
                            }.to_json , headers: {Authorization: "Bearer #{current_user.access_token}",
                            "Content-Type": "application/json"})

  end

  def browserBar

    current_user = User.find(1)
    if current_user.access_token_expired?
      body ={
        grant_type: "refresh_token",
        refresh_token: current_user.refresh_token,
        client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
        client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'

      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's acces token has not expired"
    end

    header = {
      Authorization: "Bearer #{current_user.access_token}",
      "Content-Type": "application/json"
    }
    body = {
      name: "My Playlist Test"
    }



    auth_response = RestClient::Request.execute(method: :get, url: "https://api.spotify.com/v1/search?q=#{params["_json"]}&type=track",
                           headers: {Authorization: "Bearer #{current_user.access_token}",
                            "Content-Type": "application/json"})
    render :json => JSON.parse(auth_response)


  end

  private


  def user_params
    params.permit(:username, :spotify_url, :access_token, :refresh_token, :id, :uri, :display_name, :profile_image, :user_id)
  end

  # def find_user
  #   @user = User.find(params[:id])
  # end

  def refresh_token
    current_user = find_user()

    if current_user.access_token_expired?
      body ={
        grant_type: "refresh_token",
        refresh_token: current_user.refresh_token,
        client_id: 'bd16d9f4a0d6411aae3835dcd441841e',
        client_secret: 'fa86350bbbb34a2c8e12c1564cc5e785'

      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's access token has not expired"
    end
  end

end
