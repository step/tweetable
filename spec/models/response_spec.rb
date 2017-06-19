# frozen_string_literal: true

describe Response do
  describe 'validations ' do
    it { should validate_presence_of(:text) }

    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:passage_id) }
    it { should validate_length_of(:text).is_at_most(140).on(:create).with_long_message("Tweet length can't be more than 140 characters") }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:passage) }
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
  end
end
