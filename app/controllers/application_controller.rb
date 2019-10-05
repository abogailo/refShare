require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

    use Rack::Flash

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

    get '/' do
      if logged_in?
         go_to_groups
       else
        erb :'index'
       end
    end


    helpers do

      def logged_in?
        !!session[:user_id]
      end

      def current_user
       User.find(session[:user_id])
      end

      def go_to_login
        redirect to '/'
      end

      def go_to_groups
        redirect to '/groups'
      end

      def go_to_contributions
        erb :'contributions/contributions'
      end
      
      def follows?(group_id)
        Follow.where(:user_id => current_user.id, :group_id => group_id).exists?
      end

      def get_group(group_id)
        @group = Group.find_by(:id => group_id)
        @group.name
      end

      def redirect_if_not_logged_in
        if !logged_in?
          go_to_login
        end
      end
    end
end