class Vote < ActiveRecord::Base
  attr_accessible :score_id, :user_id, :value
end
