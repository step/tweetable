class Passage < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :duration, presence: true

  has_many :responses

  def roll_out
    self.start_time = DateTime.now
    self.save
  end

  def close
    self.close_time = DateTime.now
    self.save
  end

  def self.draft_passages
    Passage.where(['start_time > ?', DateTime.now]).or(Passage.where(start_time: nil))
  end

  def self.open_passages
    Passage.where(['start_time <= ? and close_time > ?', DateTime.now, DateTime.now])
  end

  def self.closed_passages
    Passage.where(['close_time < ?', DateTime.now])
  end

end
