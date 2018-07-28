class ProjectsController < ApplicationController    
    
    get '/projects' do
        if logged_in?
          @user = current_user
          @projects = Project.all
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
            if params.values.any? { |val| val == "" }
                redirect '/projects/new'
            else
                @user = current_user
                @project = Project.create(:id => params[:id], :title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id])
                redirect to "/projects/#{@project.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/projects/:id' do
      if logged_in?
        @project = Project.find_by_id(params[:id])
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
        @project = Project.find_by_id(params[:id])
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
          if params[:content] == ""
            @project = Project.find(params[:id])
            redirect to "/projects/#{@project.id}/edit"
          else
            @project = Project.find(params[:id])
            if @project && @project.user == current_user
              @project.update(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri])
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