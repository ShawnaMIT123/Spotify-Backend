class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true

  has_many :rooms
  has_many :tracks, through: :rooms

  def access_token_expired?
    (Time.now - self.updated_at) > 3300

  end
end
