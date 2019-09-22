class User < ActiveRecord::Base
    
    include Followable::InstanceMethods

    has_secure_password
    has_many :contributions, dependent: :destroy
    has_many :groups, dependent: :destroy
    has_many :groups, through: :follows, dependent: :destroy
end