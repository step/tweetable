# frozen_string_literal: true

class CreateResponsesTracking < ActiveRecord::Migration[5.1]
  def change
    create_table :responses_trackings do |t|
      t.references :user, foreign_key: true
      t.references :passage, foreign_key: true
      t.timestamps
    end
  end
end
