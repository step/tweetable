require "#{Rails.root}/db/default_seeds"
require "#{Rails.root}/db/test_seeds"

seed_default_data

if Rails.env.test?
  seed_test_data
end
