class User < ActiveRecord::Base
  attr_accessible :email, :id_facebook, :id_twitter, :name
end
