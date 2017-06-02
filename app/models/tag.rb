class Tag < ApplicationRecord
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 15, on: :create, too_long: "Tag name length can't be more than 15 characters"

  has_many :taggings
end
