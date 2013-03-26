class Gcomment < ActiveRecord::Base
  belongs_to :gossip
  attr_accessible :body, :gossip_id, :score_id, :user_id
end
