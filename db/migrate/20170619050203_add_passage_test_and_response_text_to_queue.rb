class AddPassageTestAndResponseTextToQueue < ActiveRecord::Migration[5.1]
  def change
    add_column :response_queues, :passage_id, :integer
    add_column :response_queues, :passage_text, :string
    add_column :response_queues, :response_text, :string
  end
end
