class User < ApplicationRecord
  validates :auth_id, presence: true
end
