# frozen_string_literal: true

class Tag < ApplicationRecord
  validates_uniqueness_of :name, case_sensitive: false
  validates_length_of :name, maximum: 25, on: :create, too_long: "Tag name length can't be more than 25 characters"
  validates :color, format: {
    with: /\A#([a-fA-F0-9]{6}|[a-fA-F0-9]{3})\Z/,
    message: 'code must be a valid hex color code'
  }

  has_many :taggings, dependent: :destroy
end
