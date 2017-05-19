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
    responses.select { |response| response.passage_id.equal?(passage_id) }.first
  end

end
