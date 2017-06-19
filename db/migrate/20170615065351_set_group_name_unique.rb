# frozen_string_literal: true

class SetGroupNameUnique < ActiveRecord::Migration[5.1]
  def change
    change_column :groups, :name, :string, unique: true
  end
end
