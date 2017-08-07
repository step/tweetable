# frozen_string_literal: true

class ResponsesTracking < ApplicationRecord
  validates :user_id, presence: true
  validates :passage_id, presence: true

  belongs_to :passage
  belongs_to :user

  def self.remaining_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_or_create_by(passage_id: passage_id, user_id: user_id)
    return 0 unless tracking_detail.updated_at.eql? tracking_detail.created_at

    current_time = Time.current
    conclude_time_duration = tracking_detail.passage.conclude_time - current_time
    passage_duration = tracking_detail.passage.duration
    return conclude_time_duration if passage_duration.zero? || passage_duration.nil?

    remaining_time = passage_duration - (current_time - tracking_detail.created_at)
    [remaining_time, conclude_time_duration].min
  end

  def self.update_end_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_by(passage_id: passage_id, user_id: user_id)
    tracking_detail.touch(:updated_at)
  end
end
