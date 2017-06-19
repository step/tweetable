# frozen_string_literal: true

describe Tag, type: :model do

  it {should validate_uniqueness_of(:name)}

  it {should validate_length_of(:name).is_at_most(25).on(:create).with_long_message("Tag name length can't be more than 25 characters")}

end