class AddRolesToItsTable < ActiveRecord::Migration[5.1]
  def change
    Role.create(:title => 'ADMIN')
    Role.create(:title => 'MENTOR')
    Role.create(:title => 'EVALUATOR')
    Role.create(:title => 'INTERN')
  end
end
