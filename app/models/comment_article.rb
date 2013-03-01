class CommentArticle < ActiveRecord::Base
  attr_accessible :article_id, :content, :score_id, :user_id
end
