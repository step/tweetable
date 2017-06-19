# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :response_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
