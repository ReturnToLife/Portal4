# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  user_id          :integer
#  publication_date :datetime
#  thumbnail        :string(255)
#  nb_comments      :integer
#  content          :text
#  category         :string(255)
#  status           :integer
#  score_id         :integer
#  event_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Article < ActiveRecord::Base
  attr_accessible :category, :content, :event_id, :nb_comments, :publication_date, :score_id, :status, :thumbnail, :title, :user_id, :created_at, :id, :updated_at

  has_many :acomments
end
