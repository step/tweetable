class AddDefaultValueToTagColor < ActiveRecord::Migration[5.1]
  def change
    change_column :tags, :color, :string, default: '#5bc0de'
    Tag.all.each {|tag| tag.update_attribute(:color,'#5bc0de') if (tag.color.nil? || tag.color.empty? ) }
  end
end
