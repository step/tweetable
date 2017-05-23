class Passage < ApplicationRecord

  validates :title, presence: true
  validates :text, presence: true
  validates_numericality_of :duration, greater_than: 0

  has_many :responses, dependent: :destroy

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
    now = DateTime.now
    Passage.where(['start_time <= ? and close_time > ?', now, now])
  end

  def self.closed_passages
    Passage.where(['close_time < ?', DateTime.now])
  end

  def self.open_for_candidate(user)
    self.open_passages - user.passages
  end

  def self.missed_by_candidate(user)
    self.closed_passages - user.passages
  end

  def self.attempted_by_candidate(user)
    passages = user.passages
    responses = user.responses
    passages.map { |passage| {passage: passage, response: get_passages_with_corresponding_response(responses, passage.id)} }
  end

  private
  def self.get_passages_with_corresponding_response(responses, passage_id)
    responses.find { |response| response.passage_id.equal?(passage_id) }
  end

end
