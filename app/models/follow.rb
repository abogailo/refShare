class Follow < ActiveRecord::Base
    belongs_to :group_follower, class_name: "User"
    belongs_to :followed_group, class_name: "Group"
end