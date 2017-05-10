require 'rails_helper'

RSpec.describe User, type: :model do
  it do
    should validate_presence_of(:auth_id)
  end
end
