class AddRolesToExistingUsers < ActiveRecord::Migration[5.1]
  def change
    admin = Role.find_by(title: 'ADMIN').id
    intern = Role.find_by(title: 'INTERN').id

    User.all.each { |user|
      id = user.admin ? admin : intern
      user.update_attribute(:role_id, id)
    }
  end
end
