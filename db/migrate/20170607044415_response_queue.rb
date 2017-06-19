# frozen_string_literal: true

class ResponseQueue < ActiveRecord::Migration[5.1]
  def change
    create_table :response_queues do |t|
      t.integer :response_id
    end
  end
end
