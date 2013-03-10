class Acomment < ActiveRecord::Base
  belongs_to :article
  attr_accessible :id, :body, :user, :article_id, :created_at, :updated_at
end
