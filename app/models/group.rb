class Group < ActiveRecord::Base

    belongs_to :user
    has_many :contributions, :dependent => :destroy
    has_many :followed_groups, :through => :follows, :dependent => :destroy
    
end