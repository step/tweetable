describe ResponsesTracking do
  describe 'validations ' do
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:passage_id)}
    it {should validate_presence_of(:start_time)}

  end

  describe 'associations' do
    it {should belong_to(:user)}
    it {should belong_to(:passage)}

  end

end