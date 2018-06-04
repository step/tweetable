class AddActionAndSubjectClassToPrivileges < ActiveRecord::Migration[5.1]
  def change
    add_column :privileges, :subject_class, :string
    add_column :privileges, :action, :string
  end
end
