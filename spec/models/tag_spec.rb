# frozen_string_literal: true

describe Tag, type: :model do
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_length_of(:name).is_at_most(25).on(:create).with_long_message("Tag name length can't be more than 25 characters") }

  context 'Tag color validation' do
    context 'When hexcode length is neither 6 nor 3' do
      it { should_not allow_value('#A8B4').for(:color) }
    end

    context 'When hexcode length is 6 or 3' do
      it 'Should not allow other than hexcode' do
        should_not allow_value('#c8d0fg').for(:color)
      end

      it 'Should allow hexcode' do
        should allow_value('#A8B0FC').for(:color)
      end

      it 'Should allow hexcode with small alphabets' do
        should allow_value('#a8b0fc').for(:color)
      end

      it 'Should allow hexcode with length 3' do
        should allow_value('#A8B').for(:color)
      end
    end
  end
end
