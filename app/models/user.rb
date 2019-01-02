class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true

  has_many :rooms, foreign_key: 'owner_id'

  has_many :follows, class_name: 'Follow', foreign_key: 'participant_id'



  def access_token_expired?
    (Time.now - self.updated_at) > 3300

  end

 #  has_many :listings, foreign_key: 'host_id'


end
