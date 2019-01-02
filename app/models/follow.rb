class Follow < ApplicationRecord

belongs_to :participant, class_name: 'User'
belongs_to :room

end
