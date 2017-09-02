# frozen_string_literal: true

class Passage < ApplicationRecord
  after_initialize :defaults, unless: :persisted?

  validates :title, presence: true
  validates :text, presence: true
  validates_numericality_of :duration, greater_than_or_equal_to: 0
  validate :date_validations

  has_many :responses, dependent: :destroy
  has_many :responses_trackings, dependent: :destroy

  DEFAULT_DURATION = 3600

  scope :recently_commenced, -> { where ['(commence_time BETWEEN ? AND ?) AND (conclude_time > ?)', Time.current.ago(1.day), Time.current, Time.current] }

  def commence(conclude_time)
    update_attributes(commence_time: Time.current, conclude_time: conclude_time)
  end

  def conclude
    update_attributes(conclude_time: Time.current)
  end

  def self.drafts
    Passage.where(['commence_time > ?', Time.current]).or(Passage.where(commence_time: nil))
  end

  def self.ongoing
    now = Time.current
    Passage.where(['commence_time <= ? and conclude_time > ?', now, now])
  end

  def self.concluded
    Passage.where(['conclude_time < ?', Time.current])
  end

  def self.commence_for_candidate(user)
    ongoing_passages = ongoing
    (ongoing_passages - user.passages) - get_timed_out_passages(ongoing_passages, user.id)
  end

  def self.missed_by_candidate(user)
    timed_out_passages = get_timed_out_passages(ongoing, user.id)
    (concluded + timed_out_passages) - user.passages
  end

  def self.attempted_by_candidate(user)
    passages = user.passages
    responses = user.responses
    passages.map { |passage| { passage: passage, response: get_passages_with_corresponding_response(responses, passage.id) } }
  end

  def self.get_passages_with_corresponding_response(responses, passage_id)
    responses.find { |response| response.passage_id.equal?(passage_id) }
  end

  def self.passage_missed?(passage, user_id)
    tracking_details = ResponsesTracking.find_by(passage_id: passage.id, user_id: user_id)
    return false if tracking_details.nil?
    ResponsesTracking.remaining_time(passage.id, user_id) <= 0
  end

  def self.get_timed_out_passages(ongoing_passages, user_id)
    ongoing_passages.select { |passage| passage_missed?(passage, user_id) }
  end

  private_class_method :passage_missed?, :get_passages_with_corresponding_response, :get_timed_out_passages

  private

  def date_validations
    return if valid_commence_time?
    errors.add(:conclude_time, 'must be a future time...')
  end

  def valid_conclude_time?
    conclude_time.present? && conclude_time > commence_time
  end

  def valid_commence_time?
    return true unless commence_time.present?
    valid_conclude_time?
  end

  def defaults
    self.duration ||= DEFAULT_DURATION
  end
end
