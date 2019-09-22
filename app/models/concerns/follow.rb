  
class Followable

    module InstanceMethods
  
      def follows?(group_id)
        Follow.where(:user_id => current_user.id, :group_id => group_id)
      end
  
    end
  
  end