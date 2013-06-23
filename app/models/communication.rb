class Communication < ActiveRecord::Base
  attr_accessible :message, :purchase_id, :to_id, :user_id
end
