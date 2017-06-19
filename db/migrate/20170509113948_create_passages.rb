# frozen_string_literal: true

class CreatePassages < ActiveRecord::Migration[5.1]
  def change
    create_table :passages do |t|
      t.string :title
      t.string :text
      t.datetime :start_time
      t.datetime :close_time
      t.integer :duration
      t.string :status, default: "DRAFT"
      t.timestamps
    end
  end
end
