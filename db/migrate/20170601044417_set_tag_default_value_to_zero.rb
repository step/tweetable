# frozen_string_literal: true

class SetTagDefaultValueToZero < ActiveRecord::Migration[5.1]
  def change
    change_column :tags, :weight, :integer, default: 0
  end
end
