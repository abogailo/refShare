require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "pretty_cool_right"
      end

      get "/"do
        "Hello World"
      end
end