class Follow < ActiveRecord::Base
    belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
    belongs_to :following, foreign_key: 'group_id', class_name: 'Group' 
end