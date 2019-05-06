require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Associations' do 
    it { should have_many(:articles) }
    it { should have_many(:product_discounted_rates) }
  end
    
  describe 'Validates' do 

    it 'should have valid product' do 
      expect(FactoryGirl.build(:product)).to be_valid
    end

    it 'should require name' do 
      expect(FactoryGirl.build(:product, :name => "")).not_to be_valid
    end

    it 'should require code' do 
      expect(FactoryGirl.build(:product, :code => "")).not_to be_valid
    end

    it 'should require default imported price' do 
      expect(FactoryGirl.build(:product, :default_imported_price => "")).not_to be_valid
    end

    it 'should require default sale price' do 
      expect(FactoryGirl.build(:product, :default_sale_price => "")).not_to be_valid
    end

    it 'default imported price should be greater than 0' do 
      expect(FactoryGirl.build(:product, :default_imported_price => "-1")).not_to be_valid
    end

    it 'default sale price should be greater than 0' do 
      expect(FactoryGirl.build(:product, :default_sale_price => "-1")).not_to be_valid
    end
  end
end
