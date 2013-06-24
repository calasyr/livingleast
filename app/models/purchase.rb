class Purchase < ActiveRecord::Base
	belongs_to :user
  attr_accessible :amount, :category, :city, :merchant_name
end
