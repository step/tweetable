# frozen_string_literal: true

class ResponsesTracking < ApplicationRecord
  validates :user_id, presence: true
  validates :passage_id, presence: true

  belongs_to :passage
  belongs_to :user

  def self.remaining_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_or_create_by(passage_id: passage_id, user_id: user_id)
    return 0 unless tracking_detail.updated_at.eql? tracking_detail.created_at
    conclude_time_duration = tracking_detail.passage.conclude_time - Time.current
    passage_duration = tracking_detail.passage.duration
    remaining_time = passage_duration - (Time.current - tracking_detail.created_at)
    [remaining_time, conclude_time_duration].min
  end

  def self.update_end_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_by(passage_id: passage_id, user_id: user_id)
    tracking_detail.touch(:updated_at)
  end
end
