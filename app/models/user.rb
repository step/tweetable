# frozen_string_literal: true

class User < ApplicationRecord
  validates_uniqueness_of :auth_id, allow_nil: true
  validates :email, uniqueness: true, presence: true
  validate :validate_email, on: :create

  has_many :responses
  has_many :user_groups
  has_many :passages, through: :responses
  has_many :tags, through: :responses

  def update_if_changed(user_params)
    update_attributes(user_params)
    self
  end

  private

  def validate_email
    domain = ENV['ALLOWED_DOMAIN'] || '[A-Z0-9._%a-z\-]+'
    errors.add(:email, 'must be a valid email id...') unless valid_email?(domain, email)
  end

  def valid_email?(domain, email)
    Regexp.new('\b[A-Z0-9._%a-z\-]+@' + domain + '\.com\z').match?(email)
  end
end
