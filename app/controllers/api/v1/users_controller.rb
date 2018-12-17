class Api::V1::UsersController < ApplicationController
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

      @user.update(access_token: auth_params["access_token"], refresh_token: auth_params["refresh_token"])

      redirect_to "http://localhost:3001/success"
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







end
