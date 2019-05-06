require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do 
    it { should belong_to(:customer) }
    it { should have_many(:order_items).dependent(:destroy) }
  end 

  describe 'Validates' do 
    it 'shoulde have valid order' do 
      expect(FactoryGirl.build(:order)).to be_valid
    end

    it 'should require customer paid' do 
      expect(FactoryGirl.build(:order, :customer_paid => "")).not_to be_valid
    end
    
    it 'customer paid  should be greater than 0' do 
      expect(FactoryGirl.build(:order, :customer_paid => "-1")).not_to be_valid      
    end

  end
end 