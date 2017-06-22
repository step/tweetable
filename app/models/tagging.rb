# frozen_string_literal: true

class Tagging < ApplicationRecord
  scope :reviewed, -> { where(reviewed: true) }

  validates_uniqueness_of :response_id, scope: :tag_id

  belongs_to :tag
  belongs_to :response
end
