class Passage < ApplicationRecord

  validates :title, presence: true
  validates :text, presence: true
  validates_numericality_of :duration, greater_than: 0
  validate :is_valid_conclude_time?

  has_many :responses, dependent: :destroy
  has_many :responses_trackings, dependent: :destroy

  def commence(conclude_time)
    self.update_attributes(commence_time: Time.current,conclude_time: ( conclude_time))
  end

  def conclude
    self.conclude_time = Time.current
    self.save
  end

  def self.drafts
    Passage.where(['commence_time > ?', Time.current]).or(Passage.where(commence_time: nil))
  end

  def self.ongoing(user)
    now = Time.current
    opened_passages = Passage.where(['commence_time <= ? and conclude_time > ?', now, now])
    opened_passages - get_timed_out_passages(opened_passages,user.id)
  end

  def self.finished
    Passage.where(['conclude_time < ?', Time.current])
  end

  def self.commence_for_candidate(user)
    self.ongoing(user) - user.passages
  end

  def self.missed_by_candidate(user)
    finished = self.finished - user.passages
    now = Time.current
    opened_passages = Passage.where(['commence_time <= ? and conclude_time > ?', now, now])
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
    tracking_details = ResponsesTracking.find_by({passage_id:passage.id,user_id:user_id})
    unless tracking_details.nil?
      ResponsesTracking.remaining_time(passage.id,user_id) <= 0
    end
  end

  def self.get_timed_out_passages(ongoing_passages,user_id)
    ongoing_passages.select {|passage| is_passage_missed(passage,user_id)}
  end


  def is_valid_conclude_time?
    if (self.conclude_time.present?  and invalid_conclude_time?) or is_valid_commence_time?
      errors.add(:conclude_time, 'must be a future time...')
    end
  end

  def is_valid_commence_time?
    self.commence_time.present?  and invalid_commence_time?
  end

  def invalid_conclude_time?
    self.conclude_time <= Time.current
  end


  def invalid_commence_time?
    self.conclude_time <= self.commence_time
  end

end
