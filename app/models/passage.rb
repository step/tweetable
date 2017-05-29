class Passage < ApplicationRecord

  validates :title, presence: true
  validates :text, presence: true
  validates_numericality_of :duration, greater_than: 0
  validate :is_valid_close_date?

  has_many :responses, dependent: :destroy

  def commence(close_time)
    self.update_attributes(start_time: DateTime.now,close_time:close_time)
  end

  def close
    self.close_time = DateTime.now
    self.save
  end

  def self.drafts
    Passage.where(['start_time > ?', DateTime.now]).or(Passage.where(start_time: nil))
  end

  def self.ongoing
    now = DateTime.now
    Passage.where(['start_time <= ? and close_time > ?', now, now])
  end

  def self.finished
    Passage.where(['close_time < ?', DateTime.now])
  end

  def self.commence_for_candidate(user)
    self.ongoing - user.passages
  end

  def self.missed_by_candidate(user)
    self.finished - user.passages
  end

  def self.attempted_by_candidate(user)
    passages = user.passages
    responses = user.responses
    passages.map {|passage| {passage: passage, response: get_passages_with_corresponding_response(responses, passage.id)}}
  end

  private
  def self.get_passages_with_corresponding_response(responses, passage_id)
    responses.find {|response| response.passage_id.equal?(passage_id)}
  end

  def is_valid_close_date?
    #TODO: write test for custom validation
    if self.close_time.nil?  or greater_equal_now?
      true
    else
      errors.add(:close_time, 'must be a future time...')
    end
  end

  def greater_equal_now?
    DateTime.parse(self.close_time.to_s) >= DateTime.parse(DateTime.now.utc.to_s)
  end

end
