class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected 
  def myCeil(value)
    (value / 100.0).ceil * 100
  end

  private 
    def private_id
      SecureRandom.hex(3).upcase
    end
end
