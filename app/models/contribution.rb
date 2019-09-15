class Contribution < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
  
    belongs_to :user
    has_many :groups
  end