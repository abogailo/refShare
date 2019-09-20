class ContributionsController < ApplicationController
    #https://learn.co/tracks/full-stack-web-development-v7/sinatra/activerecord/sinatra-restful-routes
  #https://learn.co/tracks/full-stack-web-development-v7/sinatra/activerecord/sinatra-playlister
  #https://learn.co/tracks/full-stack-web-development-v7/sinatra/forms/layouts-and-yield
    require 'pry'
   #page to display all contributions, index action
  get '/contributions' do
    if logged_in?
      @contributions = current_user.contributions.all
      erb :'contributions/contributions'
    else
      "Hello World"
    end
  end

    #creates a new contribution, new action
  get '/contributions/new' do
    if logged_in?
      erb :'/contributions/create_contributions'
    else
      go_to_login
    end
  end

   #displays one contribution based on ID in the url, show action
  get '/contributions/:id' do
    if logged_in?
      @contribution = Contribution.find(params[:id])
      erb :'contributions/show_contributions'
    else
      go_to_login
    end
  end

   #displays the edit form based on ID in the url, edit action
  get '/contributions/:id/edit' do
    if logged_in?
      @contribution = Contribution.find(params[:id])
      @group = Group.find(@contribution.group_id)
      if @contribution.user_id == current_user.id
        erb :'contributions/edit_contribution'
      else
        go_to_groups
      end
    else
      go_to_login
    end
  end

   #creates a new contribution, new action
  post '/contributions' do
    if params[:name].empty? || params[:content].empty? 
      flash[:message] = "Must add content."
      redirect to "/contributions/new"
    else
      @user = current_user
      @group = Group.find_or_create_by(name:params[:group_name]) do |group|
        group.user_id = current_user.id
      end

      @contribution = Contribution.create(title:params[:name], content:params[:content], group_id:@group.id, user_id:@user.id) 
      redirect to "/contributions/#{@contribution.id}"
    end
  end

   #allows a user to edit a contribution that only they created, edit action maybe add flash to say you cant edit htis if its not the same user
  patch '/contributions/:id' do
    if !params[:name].empty? && !params[:content].empty? 
      @contribution = Contribution.find(params[:id])
      @contribution.update(name:params[:name], content:params[:content])
      @group = current_user.groups.find_by(name:params[:group_name])
      @contribution.group_id = @group.id
      @contribution.save
      flash[:message] = "All set, contribution updated."
      go_to_groups
    else
      flash[:message] = "Please, do not leave blank content."
      redirect to "/contributions/#{params[:id]}/edit"
    end
  end

  #deletes one article based on id in the url, delete action
  delete '/contributions/:id/delete' do
    if logged_in?
      @contribution = Contribution.find(params[:id])
      if @contribution.user_id == current_user.id
        @contribution.delete
        flash[:message] = "Your contribution has been deleted successfully."
        go_to_groups
      end
    else
      go_to_login
    end
  end
end