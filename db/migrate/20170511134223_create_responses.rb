# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :passage_id
      t.string :text

      t.timestamps
    end
  end
end
