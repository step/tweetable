class CreatePrivileges < ActiveRecord::Migration[5.1]
  def change
    create_table :privileges do |t|
      t.references :role, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
