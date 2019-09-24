class User < ActiveRecord::Base

    has_secure_password
    has_many :contributions, dependent: :destroy
    has_many :groups, dependent: :destroy
    has_many :groups, through: :follows, dependent: :destroy
end