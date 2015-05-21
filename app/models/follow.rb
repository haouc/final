class Follow < ActiveRecord::Base

	belongs_to :fan, class_name: 'User', foreign_key: 'fan_id'

	belongs_to :star, class_name: 'User', foreign_key: 'star_id'
	
end
