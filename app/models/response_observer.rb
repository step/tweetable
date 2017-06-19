# frozen_string_literal: true

class ResponseObserver
  def self.notify(passage, response)
    ResponseQueue.enqueue(passage, response) if Rails.env.production?
  end
end
