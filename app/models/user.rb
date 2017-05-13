class User < ApplicationRecord
  validates :auth_id, presence: true
  has_many :response
  has_many :passage, through: :response
  has_many :tag, through: :response

  def self.is_admin?(id)
      User.find_by(auth_id: id).admin
  end

end
