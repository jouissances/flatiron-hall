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
          flash[:error] = "Please register or sign in to submit a project."
          redirect '/login'
        end
    end
    
    post '/projects' do
        if logged_in?
            @user = current_user
            if params[:video_url] == '' && params[:external_uri] == ''
              params[:video_url] = Project.columns_hash['video_url'].default
              params[:external_uri] = "N/A"
              @project = Project.create(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
              flash[:success] = %Q[You have successfully submitted your project. Click <a href="/projects" id="link-underline">here</a> to return to your profile.]
              redirect to "/projects/#{@project.slug}"
            elsif params[:video_url] == ''
              params[:video_url] = Project.columns_hash['video_url'].default
              @project = Project.create(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
              flash[:success] = %Q[You have successfully submitted your project. Click <a href="/projects" id="link-underline">here</a> to return to your profile.]
              redirect to "/projects/#{@project.slug}"
            elsif params[:external_uri] = ""
              params[:external_uri] = "N/A"
              @project = Project.create(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
              flash[:success] = %Q[You have successfully submitted your project. Click <a href="/projects" id="link-underline">here</a> to return to your profile.]
              redirect to "/projects/#{@project.slug}"
            else
              @project = Project.create(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
              flash[:success] = %Q[You have successfully submitted your project. Click <a href="/projects" id="link-underline">here</a> to return to your profile.]
              redirect to "/projects/#{@project.slug}"
            end
        else
          redirect '/login'
        end
    end

    get '/projects/:slug' do
      @user = current_user
      @project = Project.find_by_slug(params[:slug])
      erb :'projects/show'
    end
  
    get '/projects/:slug/edit' do
      if logged_in?
        @project = Project.find_by_slug(params[:slug])
        if @project && @project.user == current_user
          erb :'projects/edit'
        else
          flash[:error] = "Please register or sign in to edit your project."
          redirect to '/projects'
        end
      else
        redirect to '/login'
      end
    end

    patch '/projects/:slug' do
        if logged_in?
          @project = Project.find_by_slug(params[:slug])
          if @project && @project.user == current_user
            if params[:video_url] == '' && params[:external_uri] == ''
              params[:video_url] = Project.columns_hash['video_url'].default
              params[:external_uri] = "N/A"
              @project.title = params[:title]
              @project.category = params[:category]
              @project.description = params[:description]
              @project.github = params[:github]
              @project.external_uri = params[:external_uri]
              @project.video_url = params[:video_url]
              @project.blog_url = params[:blog_url]
              @project.save
              flash[:success] = "You have successfully edited your submission."
              redirect to "/projects/#{@project.slug}"
            elsif params[:video_url] == ''
              params[:video_url] = Project.columns_hash['video_url'].default
              @project.title = params[:title]
              @project.category = params[:category]
              @project.description = params[:description]
              @project.github = params[:github]
              @project.external_uri = params[:external_uri]
              @project.video_url = params[:video_url]
              @project.blog_url = params[:blog_url]
              @project.save
              flash[:success] = "You have successfully edited your submission."
              redirect to "/projects/#{@project.slug}"
            elsif params[:external_uri] = ""
              params[:external_uri] = "N/A"
              @project.title = params[:title]
              @project.category = params[:category]
              @project.description = params[:description]
              @project.github = params[:github]
              @project.external_uri = params[:external_uri]
              @project.video_url = params[:video_url]
              @project.blog_url = params[:blog_url]
              @project.save
              flash[:success] = "You have successfully edited your submission."
              redirect to "/projects/#{@project.slug}"
            else
              @project.title = params[:title]
              @project.category = params[:category]
              @project.description = params[:description]
              @project.github = params[:github]
              @project.external_uri = params[:external_uri]
              @project.video_url = params[:video_url]
              @project.blog_url = params[:blog_url]
              @project.save
              flash[:success] = "You have successfully edited your submission."
              redirect to "/projects/#{@project.slug}"
            end
            flash[:success] = "You have successfully edited your submission."
            redirect to "/projects/#{@project.slug}"
          else
            flash[:error] = "Sorry, we're unable to do that for you right now."
            redirect to '/projects'
          end
        else
          redirect to '/login'
        end
      end
    
    delete '/projects/:slug/delete' do
        if logged_in?
            @project = Project.find_by_slug(params[:slug])
            if @project && @project.user == current_user
              @project.delete
              flash[:notice] = "You have deleted your submission."
              redirect to '/projects'
            end
        else
          flash[:error] = "Please register or sign in to delete your project."
          redirect to '/login'
        end
    end

end