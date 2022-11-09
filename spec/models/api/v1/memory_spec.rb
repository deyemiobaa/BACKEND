require 'rails_helper'

RSpec.describe Api::V1::Memory, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:api_v1_memory)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(FactoryBot.build(:api_v1_memory)).to validate_presence_of(:prompt) }
    it { expect(FactoryBot.build(:api_v1_memory)).to validate_presence_of(:story) }
    it { expect(FactoryBot.build(:api_v1_memory)).to validate_presence_of(:title) }
    it { expect(FactoryBot.build(:api_v1_memory)).to validate_presence_of(:public) }
    it { expect(FactoryBot.build(:api_v1_memory)).to validate_presence_of(:favorite) }
  end

  describe 'ActiveRecord associations' do
    it { expect(FactoryBot.build(:api_v1_memory)).to belong_to(:user) }
  end
end
