class UsersController < ApplicationController
    #takes user to groups if logged in else redirects to login form
    get '/login' do
        if logged_in?
          redirect to '/groups'
        else
          go_to_login
        end
    end
    
      #prompts loggin form
    get '/signup' do
        if logged_in?
            go_to_groups
        else
            erb :'users/create_user'
        end
    end
  
      #prompts the edit user form if user is logged in, edit action
    get '/users/:id/edit' do
        if logged_in?
          erb :'users/edit_user'
        else
          go_to_login
        end
    end
  
  
    get '/users/:id' do
        if logged_in?
          @users = User.all
          erb :'users/show'
        else
          go_to_login
        end
    end
  
    get '/logout' do
        if logged_in?
          session.destroy
          redirect "/login"
        else
          go_to_login
        end
    end
  
    post '/login' do
      user = User.find_by(:username => params[:username])
        #https://learn.co/tracks/full-stack-web-development-v7/sinatra/activerecord/securing-passwords-in-sinatra
        
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        go_to_groups
      else
        flash[:message] = "Those credentials do not match."
        go_to_login
      end
    end  
  
    patch '/users/:id' do
        if User.where(:username.downcase => params[:username].downcase).exists?
          flash[:message] = "Sorry, that username already exists!"
          redirect to '/users/:id/edit'
        elsif !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
          @user = User.find(params[:id])
          @user.update(username:params[:username], email:params[:email], password:params[:password])
          flash[:message] = "Account Updated"
          redirect to "/users/#{@user.id}"
        else
          flash[:message] = "Please don't leave blank content"
          redirect to "/users/#{params[:id]}/edit"
        end
    end
  
    post '/signup' do
        
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          flash[:message] = "Pleae don't leave blank content"
          redirect to '/signup'
        elsif User.where(:username.downcase => params[:username].downcase).exists?
          flash[:message] = "Sorry, that username already exists!"
          redirect to '/signup'
        else
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          go_to_groups
        end
    end
  
    delete '/users/:id/delete' do
        if logged_in?
          current_user.destroy
          redirect to "/logout"
        else
          go_to_login
        end
    end
end