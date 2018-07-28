class ProjectsController < ApplicationController    
    
    get '/projects' do
        if logged_in?
          @user = current_user
          @projects = Project.find_by_user_id(@user.id)
          erb :'projects/projects'
        else
          @projects = Project.all
          erb :'projects/projects'
        end
    end

    get '/projects/new' do
        if logged_in?
          erb :'projects/create'
        else
          redirect '/login'
        end
    end
    
    post '/projects' do
        if logged_in?
            @user = current_user
            if params[:title] == ""
              redirect '/projects/new'
            else
              if params[:video_url] == ""
                params[:video_url] = Project.columns_hash['video_url'].default
              end
              @project = Project.create(:id => params[:id], :title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url])
              redirect to "/projects/#{@project.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/projects/:id' do
      if logged_in?
        @user = current_user
        @project = Project.find(params[:id])
        erb :'projects/show'
      else
        redirect to '/login'
      end
    end

    get '/projects/:slug' do
      if logged_in?
        @user = current_user
        @projects = Project.all
        @project = Project.find_by_slug(params[:slug])
        erb :'projects/show'
      else
        redirect to '/login'
      end
    end
  
    get '/projects/:id/edit' do
      if logged_in?
        @project = Project.find(params[:id])
        if @project && @project.user == current_user
          erb :'projects/edit'
        else
          redirect to '/projects'
        end
      else
        redirect to '/login'
      end
    end

    patch '/projects/:id' do
        if logged_in?
          @user = current_user
          @project = Project.find(params[:id])
          if params[:title] == ""
            redirect to "/projects/#{@project.id}/edit"
          else
            if @project && @project.user == current_user
              @project.update(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :video_url => params[:video_url])
              redirect to "/projects/#{@project.id}"
            else
              redirect to '/projects'
            end
          end
        else
          redirect to '/login'
        end
      end
    
    delete '/projects/:id/delete' do
        if logged_in?
            @user = current_user
            @project = Project.find(params[:id])
            if @project && @project.user == current_user
                @project.destroy
            end
            redirect to '/projects'
        else
          redirect to '/login'
        end
    end

end