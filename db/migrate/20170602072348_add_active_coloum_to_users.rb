# frozen_string_literal: true

class AddActiveColoumToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :active, :boolean, default: false
  end
end
