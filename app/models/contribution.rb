class Contribution < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
  
    belongs_to :user
    belongs_to :group
  end