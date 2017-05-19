class Response < ApplicationRecord
  belongs_to :passage
  belongs_to :user
  has_many :tagging
  has_many :tag, through: :tagging
  accepts_nested_attributes_for :user, :passage

end
