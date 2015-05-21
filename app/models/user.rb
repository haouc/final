class User < ActiveRecord::Base

	has_many :tweet, class_name: 'Tweet', foreign_key: 'user_id'

	has_many :comment, class_name: 'Comment', foreign_key: 'user_id'

	has_many :follows, class_name: 'Follow'

	has_many :fans, class_name: 'User', :through => :follows

	has_many :stars, class_name: 'User', :through => :follows

	validates_presence_of :username
	validates :username, :uniqueness => true
  validates_presence_of :email
  validates :email, :uniqueness => true
  validates_presence_of :password
end
