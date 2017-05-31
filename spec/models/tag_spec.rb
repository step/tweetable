describe Tag, type: :model do
  it do
    should validate_uniqueness_of(:name)
  end
end