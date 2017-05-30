class Passage < ApplicationRecord

  validates :title, presence: true
  validates :text, presence: true
  validates_numericality_of :duration, greater_than: 0
  validate :is_valid_close_date?

  has_many :responses, dependent: :destroy
  has_many :responses_trackings, dependent: :destroy

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

  def self.ongoing(user)
    now = DateTime.now
    opened_passages = Passage.where(['start_time <= ? and close_time > ?', now, now])
    opened_passages - get_timed_out_passages(opened_passages,user.id)
  end

  def self.finished
    Passage.where(['close_time < ?', DateTime.now])
  end

  def self.commence_for_candidate(user)
    self.ongoing(user) - user.passages
  end

  def self.missed_by_candidate(user)
    finished = self.finished - user.passages
    now = DateTime.now
    opened_passages = Passage.where(['start_time <= ? and close_time > ?', now, now])
    finished + self.get_timed_out_passages(opened_passages,user.id)
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

  def self.is_passage_missed(passage,user_id)
    ResponsesTracking.remaining_time(passage.id,user_id) <= 0
  end

  def self.get_timed_out_passages(ongoing_passages,user_id)
    ongoing_passages.select {|passage| is_passage_missed(passage,user_id)}
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
