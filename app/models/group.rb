class Group < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
    
    belongs_to :user
    has_and_belongs_to_many :contributions, :dependent => :destroy
    has_many :users, through: :follows

end