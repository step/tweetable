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
end
