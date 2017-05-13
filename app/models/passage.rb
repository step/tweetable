class Passage < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :duration, presence: true

  has_many :responses

  def roll_out
    self.start_time = DateTime.now
    self.save()
  end

  def close
    self.close_time = DateTime.now
    self.save()
  end

  def self.query_passages_by_status(state)
    case state
      when 'DRAFT'
        Passage.where(['start_time > ?',DateTime.now]).or(Passage.where(start_time: nil))
      when 'OPENED'
        Passage.where(['start_time <= ? and close_time > ?',DateTime.now,DateTime.now])
      else
        []
    end
  end
end
