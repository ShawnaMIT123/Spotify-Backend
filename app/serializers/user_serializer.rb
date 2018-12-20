class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :spotify_url, :access_token, :refresh_token, :uri
end
