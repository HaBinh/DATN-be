class Customer < ApplicationRecord
	# before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validates :email, presence: false, length: { maximum: 255 },
  #                   format:     { with: VALID_EMAIL_REGEX }
  validates :phone, length: { maximum: 50 }
  has_many :orders, dependent: :destroy

  def toggle_active
    self.active = !self.active 
    self.save
  end

  def self.get_pagination(page, per_page, search_text)
    if !search_text.blank?
      search_text = "%#{search_text}%"
      khachhang = Customer.where("active = true and (name LIKE '#{search_text}' or
                                  phone LIKE '#{search_text}' or address LIKE '#{search_text}'
                                  or email LIKE '#{search_text}')")
                          .paginate(:page => page, :per_page => per_page)
      total = Customer.where("active = true and (name LIKE '#{search_text}' or
                              phone LIKE '#{search_text}' or address LIKE '#{search_text}'
                              or email LIKE '#{search_text}')").count
    elsif page 
      khachhang = Customer.where(active: true).paginate(:page => page, :per_page => per_page)
      total = khachhang.count
    else 
      khachhang = Customer.where(active: true)
      total = khachhang.count
    end
    return khachhang, total
  end
end
