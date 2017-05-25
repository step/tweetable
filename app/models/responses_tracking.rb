class ResponsesTracking < ApplicationRecord
  validates :user_id, presence: true
  validates :passage_id, presence: true
  validates :start_time, presence: true

  belongs_to :passage
  belongs_to :user

end
