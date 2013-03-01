class User < ActiveRecord::Base
  attr_accessible :avatar_url, :city, :email, :firstname, :lastname, :login, :photo_url, :promo_id, :report_url, :school_id, :uid
end
