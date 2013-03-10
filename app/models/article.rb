class Article < ActiveRecord::Base
  attr_accessible :category, :content, :event_id, :nb_comments, :publication_date, :score_id, :status, :thumbnail, :title, :user_id, :created_at, :id, :updated_at

  has_many :acomments
end
