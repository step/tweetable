# frozen_string_literal: true

class ResponseQueue < ApplicationRecord
  validates_uniqueness_of :response_id

  def self.enqueue(response_id)
    ResponseQueue.create({response_id: response_id})
  end

  def self.fetch
    ResponseQueue.first
  end

  def self.ack response_job
    response_job.destroy
  end
end
