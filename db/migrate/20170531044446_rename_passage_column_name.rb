# frozen_string_literal: true

class RenamePassageColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :passages, :start_time, :commence_time
    rename_column :passages, :close_time, :conclude_time
  end
end
