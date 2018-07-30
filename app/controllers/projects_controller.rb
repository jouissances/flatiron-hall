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
            if params.except(:video_url).values.any? { |val| val == "" }
              redirect '/projects/new'
            elsif params[:video_url] == ''
              params[:video_url] = "https://previews.dropbox.com/p/orig/AALLu4qexe4eU7T5bGxzyH9_PR8rB915D7agQUw_uIzME3onBZDmO12fowl6_McLBUqDARxX3KSMvEATbxJee989K67r4KKGASU1-9165ihl1tIUQXq59G-3vHdEKiTI2J2WfY2Vu9hP3GYc_Iew4HQx7aaOYTLugxx-m9Xj6ENJmNCmYfcOIdKId_kGbeGysGcCYA_WpGkP-fCT_ClrTCkt/p.gif?size=1024x768&size_mode=3"
              # Project.columns_hash['video_url'].default
              @project = Project.create(:id => params[:id], :title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
              redirect to "/projects/#{@project.slug}"
            else
              @project = Project.create(:id => params[:id], :title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :user_id => session[:user_id], :video_url => params[:video_url], :blog_url => params[:blog_url], :created_at => params[:created_at])
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
          redirect to '/projects'
        end
      else
        redirect to '/login'
      end
    end

    patch '/projects/:slug' do
        if logged_in?
          @user = current_user
          @project = Project.find_by_slug(params[:slug])
          if params[:title] == ""
            redirect to "/projects/#{@project.slug}/edit"
          else
            if @project && @project.user == current_user
              @project.update(:title => params[:title], :category => params[:category], :description => params[:description], :github => params[:github], :external_uri => params[:external_uri], :video_url => params[:video_url], :blog_url => params[:blog_url])
              redirect to "/projects/#{@project.slug}"
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
            @project = Project.find_by_slug(params[:slug])
            if @project && @project.user == current_user
                @project.destroy
            end
            redirect to '/projects'
        else
          redirect to '/login'
        end
    end

end