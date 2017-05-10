require 'rails_helper'

RSpec.describe Passage, type: :model do
  describe "should " do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:text) }

    it { should validate_presence_of(:duration) }
  end
end
