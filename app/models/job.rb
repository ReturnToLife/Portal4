class Job < ActiveRecord::Base
  attr_accessible :group_id, :job, :user_id
end
