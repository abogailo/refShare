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
         go_to_contributions
       end
    end

    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
       User.find(session[:user_id])
      end

      def go_to_home
        erb :'index'
      end

      def go_to_groups
        redirect to '/groups'
      end

      def go_to_contributions
        erb :'contributions/contributions'
      end

    end
end