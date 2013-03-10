# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string(255)
#  firstname  :string(255)
#  lastname   :string(255)
#  promo_id   :integer
#  school_id  :integer
#  city       :string(255)
#  photo_url  :string(255)
#  avatar_url :string(255)
#  uid        :integer
#  report_url :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :avatar_url, :city, :email, :firstname, :lastname, :login, :photo_url, :promo_id, :report_url, :school_id, :uid
end
