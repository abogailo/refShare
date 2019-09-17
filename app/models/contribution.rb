class Contribution < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
  
    belongs_to :user
    has_and_belongs_to_many :groups
  end