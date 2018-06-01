require "#{Rails.root}/db/default_seeds"
require "#{Rails.root}/db/test_seeds"
require "#{Rails.root}/db/development_seeds"

if Rails.env.production?
  seed_default_data
end

if Rails.env.test?
  seed_roles_if_not_present
  seed_test_data
end

if Rails.env.development?
  seed_roles_if_not_present
  seed_development_data
end
