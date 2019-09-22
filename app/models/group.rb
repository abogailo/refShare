class Group < ActiveRecord::Base

    include Followable::InstanceMethods
    
    belongs_to :user
    has_many :contributions, :dependent => :destroy
    has_many :users, through: :follows

end