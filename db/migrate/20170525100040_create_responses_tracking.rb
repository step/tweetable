class CreateResponsesTracking < ActiveRecord::Migration[5.1]
  def change
    create_table :responses_trackings do |t|
      t.references :user, foreign_key: true
      t.references :passage, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
    end
  end
end
