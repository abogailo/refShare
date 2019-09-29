class Group < ActiveRecord::Base
    belongs_to :user
    has_many :follows, dependent: :destroy
    has_many :group_followers, through: :follows, source: :user
    has_many :contributions, :dependent => :destroy  
end