require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

    use Rack::Flash

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "pretty_cool_right"
    end

    get '/' do
      if logged_in?
          go_to_groups
       else
          erb :index
       end
    end

    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        @current_user ||= User.find(session[:user_id])
      end

      def go_to_home
        erb :'index'
      end

      def go_to_groups
        erb :'groups/groups'
      end

      def go_to_contributions
        erb :'contributions/contributions'
      end

    end
end