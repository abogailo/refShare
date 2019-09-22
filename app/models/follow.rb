class Follow < ActiveRecord::Base
    include Followable::InstanceMethods

    belongs_to :user
    belongs_to :group
end