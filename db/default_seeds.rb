def seed_default_data
  seed_admin_user
  seed_roles
end

def seed_roles
  Role.create(:title => 'ADMIN')
  Role.create(:title => 'MENTOR')
  Role.create(:title => 'EVALUATOR')
  Role.create(:title => 'INTERN')
end

def seed_admin_user
  unless ENV['TWEETABLE_ADMIN_EMAIL']
    puts 'run this command to seed admin user ==>'
    puts "\t source TWEETABLE_ADMIN_EMAIL=admin_email@domain"
    exit 1
  end
  User.create(email:ENV['TWEETABLE_ADMIN_EMAIL'],admin: true, active: true)
end