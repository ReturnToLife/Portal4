class Event < ActiveRecord::Base
  attr_accessible :date, :score_id, :user_id
end
