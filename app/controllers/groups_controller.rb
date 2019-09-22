class GroupsController < ApplicationController
    #allows user to view all user groups while logged in, view action
  get '/groups' do
    if logged_in?
      @groups = Group.all
      erb :'groups/groups'
    else
      erb :'index'
    end
  end

  get '/groups/new' do
    if logged_in?
      erb :'/groups/create_group'
    else
      go_to_login
    end
  end

  #displays a single group by group id with all its contributions, view action
  get '/groups/:id' do
    if logged_in?
      @group = Group.find(params[:id])
      @contribution = Contribution.all
      erb :'groups/show_group'
    else
      go_to_groups
    end
  end

  # add a contribution through a group create action
  get '/groups/:id/add' do
    if logged_in?
      @group = Group.find(params[:id])
      @contribution = Contribution.all
      erb :'groups/add_contribution'
    else
      go_to_groups
    end
  end

  #allows user to edit a group if they created it, displays edit form based on ID in the url, edit action
  get '/groups/:id/edit' do
    if logged_in?
      @group = Group.find(params[:id])
      if @group.user_id == current_user.id
        erb :'groups/edit_group'
      else
        go_to_groups
      end
    else
      go_to_login
    end
  end

  #edit action

  patch '/groups/:id' do
    #do I need the logged in?
    if !params[:name].empty?
      @group = Group.find(params[:id])
      @group.update(name:params[:name])
      flash[:message] = "All set got yerself a new name!"
      go_to_groups
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/groups/#{params[:id]}/edit"
    end
  end

   #when editing a group
  get '/groups/contributions/:id/edit' do
    if logged_in?
      @contribution = Contribution.find(params[:id])
      @group = Group.find(@contribution.group_id)
      if @contribution.user_id == current_user.id
        erb :'contributions/edit_contributions'
      else
        go_to_groups
      end
    else
      go_to_login
    end
  end

  #creates a new group, create action
  post '/groups' do
    if params[:name].empty?
      flash[:message] = "Please, enter a group."
      go_to_groups
    else
      @user = current_user
      @group = Group.create(name:params[:name], user_id:@user.id)
      go_to_groups
    end
  end

  post '/groups/:id/add_contributions' do
    if params[:name].empty? || params[:content].empty? 
      flash[:message] = "Must add content."
      redirect to "/contributions/new" #need to figure out what to do here
    else
      @user = current_user
      @group = Group.find(params[:id]) do |group|
        group.user_id = current_user.id
      end

      @contribution = Contribution.create(title:params[:name], content:params[:content], group_id:@group.id, user_id:@user.id) 
      redirect to "/groups/#{@group.id}"
    end
  end


  #deletes group, delete action
  delete '/groups/:id/delete' do
    if logged_in?
        @group = Group.find(params[:id])
        if @group.user_id == current_user.id
          @group.destroy
          flash[:message] = "Your group has been deleted successfully."
          go_to_groups
        end
    else
      go_to_login
    end
  end
end