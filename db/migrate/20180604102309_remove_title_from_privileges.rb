class RemoveTitleFromPrivileges < ActiveRecord::Migration[5.1]
  def change
    remove_column :privileges, :title, :string
  end
end
