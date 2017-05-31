class Tag < ApplicationRecord
  validates_uniqueness_of :name

  has_many :taggings
end
