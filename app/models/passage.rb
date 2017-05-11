class Passage < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :duration, presence: true

  has_many :response
  def open?
    self.status.eql? "OPEN"
  end

end
