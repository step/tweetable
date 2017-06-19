# frozen_string_literal: true

class Tag < ApplicationRecord
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 25, on: :create, too_long: "Tag name length can't be more than 25 characters"

  has_many :taggings
end
