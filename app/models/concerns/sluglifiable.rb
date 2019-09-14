  
module Slugifiable

    module ClassMethod

       def find_by_slug(slug)
           self.all.detect {|instance| instance.slug == slug}
       end

    end

    module InstanceMethod
        def slug
           name.downcase.gsub(' ', '-')
        end
    end

end