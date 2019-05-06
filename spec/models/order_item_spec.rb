require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Associations' do 
    it { should have_many(:articles) }
    it { should belong_to(:order)}
  end  

  describe 'Validates' do 
    it 'should greater than 0' do 
      expect(FactoryGirl.build(:order_item, :quantity => "-1")).not_to be_valid
    end

    it 'should greater than -1' do 
      expect(FactoryGirl.build(:order_item, :discounted_rate => "-1")).not_to be_valid
    end

    it 'should calculate exactly amount' do 
      order_item = FactoryGirl.build(:order_item, :quantity => 2, :discounted_rate => 0)
      order_item.calculate_amount(1000)
      expect(order_item.amount).to eq(2000)
    end
  end
end