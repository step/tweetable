# frozen_string_literal: true

class Tagging < ApplicationRecord
  scope :include_unpublished, -> {}
  default_scope { where(reviewed: true) }

  validates_uniqueness_of :response_id, scope: :tag_id

  belongs_to :tag
  belongs_to :response
end
