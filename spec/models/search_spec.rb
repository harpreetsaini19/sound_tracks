require 'rails_helper'

RSpec.describe Search, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe Search do

    before(:each) do
      create(:user)
    end
    
    it 'has a valid factory' do
      expect(build(:search)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:search, :second)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:search, :third)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:search, :fourth)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:search, :fifth)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:search, :sixth)).to be_valid
    end

    it 'is invalid without artist name' do
      expect(build(:search, artist_name: nil)).to_not be_valid
    end

    it 'is invalid without user id' do
      expect(build(:search, user_id: nil)).to_not be_valid
    end

    it 'is invalid if user not exist' do
      expect(build(:search, user_id: 9999999)).to_not be_valid
    end    
  end
end
