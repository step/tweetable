class ResponsesTracking < ApplicationRecord
  validates :user_id, presence: true
  validates :passage_id, presence: true
  validates :start_time, presence: true

  belongs_to :passage
  belongs_to :user

  def self.remaining_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_by({passage_id: passage_id, user_id: user_id})
    if tracking_detail.nil?
      tracking_detail = create_tracking_details(passage_id, user_id)
    end
    close_time_duration = tracking_detail.passage.close_time - DateTime.now.utc
    passage_duration = tracking_detail.passage.duration
    remaining_time = passage_duration - (DateTime.now.utc - tracking_detail.start_time)
    [remaining_time,close_time_duration].min
  end

  def self.create_tracking_details(passage_id, user_id)
    ResponsesTracking.create({passage_id: passage_id, user_id: user_id, start_time: DateTime.now})
  end

  def self.update_end_time(passage_id, user_id)
    tracking_detail = ResponsesTracking.find_by({passage_id: passage_id, user_id: user_id})
    tracking_detail.update_attributes(end_time:DateTime.now)
  end
end
