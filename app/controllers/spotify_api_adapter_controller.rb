class SpotifyApiAdapterController < ApplicationController
  def self.refresh_token
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
  end
end
