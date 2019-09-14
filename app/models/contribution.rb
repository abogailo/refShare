class Contribution < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
  
    belongs_to :user
    has_many :contributions_groups
    has_many :groups, through: :contributions_groups
  end