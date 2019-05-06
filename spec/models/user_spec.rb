require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validates' do 
    it 'should return if user is manager' do 
      expect(FactoryGirl.build(:user, :role => "manager").isManager).to be(true)
    end

    it 'should return false if user is not manager' do 
      expect(FactoryGirl.build(:user).isManager).to be(false)
    end

    it 'return true if user default' do 
      expect(FactoryGirl.build(:user).isActive).to be(true)        
    end

    it 'return false after toogle active' do 
      user = FactoryGirl.create(:user)
      user.toggle_active
      expect(user.isActive).to be(false)
    end

  end
end 