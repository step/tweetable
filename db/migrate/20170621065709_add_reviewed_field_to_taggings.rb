class AddReviewedFieldToTaggings < ActiveRecord::Migration[5.1]
  def change
    add_column :taggings, :reviewed, :boolean, default: false
  end
end
