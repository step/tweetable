# frozen_string_literal: true

class ResponseQueue < ApplicationRecord
  validates_uniqueness_of :response_id

  def self.enqueue(passage, response)
    ResponseQueue.create(response_id: response.id, response_text: response.text, passage_id: passage.id, passage_text: passage.text)
  end

  def self.fetch
    ResponseQueue.first
  end

  def self.ack(response_job)
    response_job.destroy
  end
end
