class CommentEvent < ActiveRecord::Base
  attr_accessible :content, :event_id, :score_id, :user_id
end
