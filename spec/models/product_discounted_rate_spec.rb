require 'rails_helper'

RSpec.describe ProductDiscountedRate, type: :model do
  describe 'Associations' do 
     it { should belong_to(:product) }
  end
end
