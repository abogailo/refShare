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

  #displays a single group by group id, view action
  get '/groups/:id' do
    if logged_in?
      @group = Group.find(params[:id])

      erb :'groups/show_group'
    else
      go_to_groups
    end
  end

  get '/groups/:id/add' do
    if logged_in?
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

  #edit contribution through user while user is logged in
  get '/groups/contributions/:id/edit' do
    if logged_in?
      @contribution = Contribution.find(params[:id])
      @group = Group.find(@contribution.group_id)
      if @contribution.user_id == session[:user_id]
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

  

  #deletes one group based on ID in the url, delete action
  delete '/groups/:id/delete' do
    if logged_in?
      if current_user.groups.size == 1
        flash[:message] = "You need to enter at least one group."
        go_to_groups
      else
        @group = Group.find(params[:id])
        if @group.user_id == current_user.id
          @group.destroy
          flash[:message] = "Your group has been deleted successfully."
          go_to_groups
        end
      end
    else
      go_to_login
    end
  end
end