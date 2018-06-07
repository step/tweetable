# frozen_string_literal: true

class User < ApplicationRecord

  before_validation :default_values

  validates_uniqueness_of :auth_id, allow_nil: true
  validates :email, uniqueness: true, presence: true
  validate :validate_email, on: :create

  belongs_to :role
  has_many :responses
  has_many :user_groups
  has_many :passages, through: :responses
  has_many :tags, through: :responses

  def update_if_changed(user_params)
    update_attributes(user_params)
    self
  end

  def self.filter_by_passage(passage_id, status)
    responses = Response.where(passage_id: passage_id).map(&:user_id)
    if status == :done
      return User.active_interns.where(id: responses)
    end
    User.active_interns.where.not(id: responses, name: nil)
  end

  def self.active_interns
    User.where(active: true).joins(:role).merge(Role.interns)
  end

  def self.interns_count
    User.where(active: true).joins(:role).merge(Role.interns).count
  end

  def is_intern
    self.role.is_intern
  end

  private

  def validate_email
    domain = ENV['ALLOWED_DOMAIN'] || '[A-Z0-9._%a-z\-]+\.com\z'
    errors.add(:email, 'must be a valid email id...') unless valid_email?(domain, email)
  end

  def valid_email?(domain, email)
    Regexp.new('\b[A-Z0-9._%a-z\-]+@' + domain).match?(email)
  end

  def default_values
    self.role_id = self.role_id != nil ? self.role_id : Role.intern.id
  end

end
