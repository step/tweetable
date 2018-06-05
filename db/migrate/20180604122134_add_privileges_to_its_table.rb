class AddPrivilegesToItsTable < ActiveRecord::Migration[5.1]
  def change
    admin_id = Role.admin.id

    Privilege.create(:role_id => admin_id, :action => 'manage', :subject_class => 'Passage')
    Privilege.create(:role_id => admin_id, :action => 'commenced', :subject_class => 'Passage', :can_access => false)
    Privilege.create(:role_id => admin_id, :action => 'attempted', :subject_class => 'Passage', :can_access => false)
    Privilege.create(:role_id => admin_id, :action => 'missed', :subject_class => 'Passage', :can_access => false)
    Privilege.create(:role_id => admin_id, :action => 'manage', :subject_class => 'User')
    Privilege.create(:role_id => admin_id, :action => 'manage', :subject_class => 'Tagging')
    Privilege.create(:role_id => admin_id, :action => 'manage', :subject_class => 'Tag')

    intern_id = Role.intern.id

    Privilege.create(:role_id => intern_id, :action => 'index', :subject_class => 'Passage')
    Privilege.create(:role_id => intern_id, :action => 'commenced', :subject_class => 'Passage')
    Privilege.create(:role_id => intern_id, :action => 'missed', :subject_class => 'Passage')
    Privilege.create(:role_id => intern_id, :action => 'attempted', :subject_class => 'Passage')
    Privilege.create(:role_id => intern_id, :action => 'update', :subject_class => 'User')
    Privilege.create(:role_id => intern_id, :action => 'review_taggings', :subject_class => 'Tagging')

    evaluator_id = Role.evaluator.id

    Privilege.create(:role_id => evaluator_id, :action => 'ongoing', :subject_class => 'Passage')
    Privilege.create(:role_id => evaluator_id, :action => 'concluded', :subject_class => 'Passage')
    Privilege.create(:role_id => evaluator_id, :action => 'update', :subject_class => 'User')
    Privilege.create(:role_id => evaluator_id, :action => 'manage', :subject_class => 'Tagging')
  end
end
