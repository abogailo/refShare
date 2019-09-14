class User < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
    
    has_secure_password
    has_many :follows, dependent: :destroy
    has_many :contributions, dependent: :destroy
    has_many :groups, through: :contributions
end