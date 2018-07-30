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
            flash[:error] = "Please fill out all fields."
            redirect '/register'
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            flash[:success] = "You have successfully registered."
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
            flash[:success] = "You have successfully logged in."
            redirect '/projects'
        elsif
            params.values.any? { |val| val == "" }
            flash[:error] = "Please fill out all fields."
            redirect '/login'
        else
            flash[:error] = "Username and password does not match. Please try again."
            redirect '/login'
        end  
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            @projects = Project.find_by_user_id(@user.id)            
            erb :'users/show'
        else
            flash[:error] = "Please register or log in to view this user's profile."
            redirect to '/login'
        end
    end

    get '/logout' do 
        if session[:user_id] != nil
          session.destroy
          flash[:notice] = "You have successfully logged out."
          redirect '/login'
        else
          redirect '/login'
        end
    end

end