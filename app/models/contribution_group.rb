class ContributionGroup < ActiveRecord::Base
    extend Slugifiable::ClassMethod
    include Slugifiable::InstanceMethod
    
    belongs_to :group
    belongs_to :contribution
end