# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin, default: false
      t.string :auth_id
      t.string :image_url
      t.timestamps
    end
  end
end
