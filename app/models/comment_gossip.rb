class CommentGossip < ActiveRecord::Base
  attr_accessible :content, :gossip_id, :score_id, :user_id
end
