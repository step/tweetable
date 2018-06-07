class AddPassagePrivilegeToEvaluator < ActiveRecord::Migration[5.1]
  def change
    evaluator_id = Role.evaluator.id

    Privilege.create(:role_id => evaluator_id, :action => 'index', :subject_class => 'Passage')
  end
end
