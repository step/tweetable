class AddManageTagsPrivilegeToEvaluator < ActiveRecord::Migration[5.1]
  def change
    evaluator_id = Role.evaluator.id

    Privilege.create(:role_id => evaluator_id, :action => 'manage', :subject_class => 'Tag')
  end
end
