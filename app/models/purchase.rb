class Purchase < ActiveRecord::Base
  attr_accessible :amount, :category, :city, :merchant_name
end
