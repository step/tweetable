# frozen_string_literal: true

class Tag < ApplicationRecord
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 25, on: :create, too_long: "Tag name length can't be more than 25 characters"
  validates :color, format: {
    with: /\A#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})\z/,
    message: proc { |_, attributes| "#{attributes[:value]} is not avalid color code." }
  }

  has_many :taggings, dependent: :destroy
end
