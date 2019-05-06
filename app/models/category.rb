class Category < ApplicationRecord
  has_many :products
  def self.get_pagination(page, per_page, search_text)
    
    if page.presence
      @ketqua = Category.paginate(:page => page, :per_page => per_page)
    else 
      @ketqua = Category.all
    end
    @total = Category.count
  return @ketqua, @total
  end
end
