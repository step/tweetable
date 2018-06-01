def seed_default_data
  seed_admin_user
end

def seed_admin_user
  unless ENV['TWEETABLE_ADMIN_EMAIL']
    puts 'run this command to seed admin user ==>'
    puts "\t source TWEETABLE_ADMIN_EMAIL=admin_email@domain"
    exit 1
  end
  User.create(email:ENV['TWEETABLE_ADMIN_EMAIL'], active: true)
end

def seed_roles_if_not_present
  ['ADMIN', 'MENTOR', 'EVALUATOR', 'INTERN'].each { |role|
    unless Role.find_by(title: role).present?
      Role.create(title: role)
    end
  }
end