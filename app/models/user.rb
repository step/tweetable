class User < ApplicationRecord
  validates_uniqueness_of :auth_id
  validates :email, uniqueness: true, presence: true

  has_many :responses
  has_many :passages, through: :responses
  has_many :tag, through: :responses

  def self.is_admin?(id)
    User.find_by(auth_id: id).admin
  end

  def update_if_changed(user_params)
    self.update_attributes(user_params)
    self
  end
end
