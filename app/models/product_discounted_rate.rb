class ProductDiscountedRate < ApplicationRecord
  belongs_to :product , optional: true
end
