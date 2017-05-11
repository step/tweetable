class User < ApplicationRecord
  validates :auth_id, presence: true
  has_many :response
  has_many :passage, through: :response
  has_many :tag, through: :response

end
