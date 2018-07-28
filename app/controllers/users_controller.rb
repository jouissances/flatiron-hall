class UsersController < ApplicationController

    get '/register' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect '/projects'
        end 
    end
    
    post '/register' do
        if params.values.any? { |val| val == "" }
            redirect '/register'
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect '/projects'
        end
    end
    
    get '/login' do
        if !logged_in?
          erb :'users/login'
        else
          redirect '/projects'
        end
    end
    
    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/projects'
        else
            redirect '/login'
        end  
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            @projects = Project.all
            erb :'users/show'
        else
            redirect to '/login'
        end
    end

    get '/logout' do 
        if session[:user_id] != nil
          session.destroy
          redirect '/login'
        else
          redirect '/projects'
        end
    end

end