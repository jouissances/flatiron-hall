require './config/environment'
require 'sinatra'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

    configure do
        enable :sessions
        register Sinatra::Flash
        set :session_secret, 'hall_secret'
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/' do
        @projects = Project.all.sort { |x, y| y.id <=> x.id }
        erb :index
    end

    get '/home' do
        @projects = Project.all.sort { |x, y| y.id <=> x.id }
        erb :index
    end

    get '/about' do
        erb :about
    end

    get '/error' do
        erb :error
    end

    helpers do
        def logged_in?
            !!session[:user_id]
        end

        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end
    end

end