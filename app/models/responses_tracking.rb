class ResponsesTracking < ApplicationRecord
  validates :user_id, presence: true
  validates :passage_id, presence: true

  belongs_to :passage
  belongs_to :user

  def self.remaining_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_or_create_by({passage_id: passage_id, user_id: user_id})
    unless tracking_detail.updated_at.eql?tracking_detail.created_at
      return 0
    end
    close_time_duration = tracking_detail.passage.close_time - DateTime.now.utc
    passage_duration = tracking_detail.passage.duration
    remaining_time = passage_duration - (DateTime.now.utc - tracking_detail.created_at)
    [remaining_time, close_time_duration].min
  end

  def self.update_end_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_by({passage_id: passage_id, user_id: user_id})
    tracking_detail.touch(:updated_at)
  end
end
