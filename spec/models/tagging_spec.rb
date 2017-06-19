# frozen_string_literal: true

describe Tagging, type: :model do
  it do
    should validate_uniqueness_of(:response_id).scoped_to(:tag_id)
  end
end
