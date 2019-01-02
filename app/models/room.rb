class Room < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :participants, through: :follows, class_name: 'User'
  has_many :follows

  has_many :tracks

end
