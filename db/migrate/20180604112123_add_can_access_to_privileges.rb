class AddCanAccessToPrivileges < ActiveRecord::Migration[5.1]
  def change
    add_column :privileges, :can_access, :bool
  end
end
