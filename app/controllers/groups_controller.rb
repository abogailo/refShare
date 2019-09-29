class GroupsController < ApplicationController
    #allows user to view all user groups while logged in, view action
  get '/groups' do
    if logged_in?
      @groups = Group.all
      @user_groups = current_user.groups.all
      @follows = Follow.all
      @user_follows = current_user.follows.all
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
      erb :'groups/show_group'
    else
      go_to_groups
    end
  end

  # add a contribution through a group create action
  get '/groups/:id/add' do
    if logged_in?
      @user = current_user
      @group = Group.find(params[:id])
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
    @group = Group.find(params[:id])
    if @group.user_id == current_user.id
        if !params[:name].empty?
          @group.update(name:params[:name])
          flash[:message] = "All set got yerself a new name!"
          go_to_groups
        else
          flash[:message] = "Please don't leave blank content"
          redirect to "/groups/#{params[:id]}/edit"
        end
    else
      go_to_groups
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

  #when editing a follow
  get '/groups/:id/_unfollow' do
    if logged_in?
      @group = Group.find(params[:id])
      @follow = Follow.find_by(group_id: params[:id])
        erb :'follows/unfollow'
    else
      go_to_login
    end
  end

  get '/groups/:id/follow' do
    if logged_in?
      @group = Group.find(params[:id])
      @follow = Follow.find_by(group_id: params[:id])
        erb :'follows/follow'
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
    if params[:title].empty? || params[:content].empty? 
      flash[:message] = "Must add content."
      redirect to "/contributions/new" #need to figure out what to do here
    else
      @user = current_user
      @group = Group.find(params[:id]) do |group|
        group.user_id = current_user.id
      end

      @contribution = Contribution.create(title:params[:title], content:params[:content], group_id:params[:id], user_id:@user.id) 
      go_to_groups
    end
  end

  post '/groups/:id/follow' do
    if logged_in?
      @group = Group.find(params[:id])
      @follow = Follow.create(group_id:@group.id, user_id:current_user.id)
      go_to_groups
    else
      go_to_login
    end
  end

  delete '/groups/:id/unfollow' do
    if logged_in?
        @follow = Follow.find(params[:id])
        if @follow.user_id == current_user.id
          @follow.destroy
          flash[:message] = "Group has been unfollowed."
          go_to_groups
        end
    else
      go_to_login
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