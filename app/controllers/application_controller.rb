require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_secure"
    use Rack::Flash
  end

  get "/" do
    erb :'welcome'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:id]) if session[:id]
    end

    def existing_user
      @user = User.find_by(email: params[:email])
    end

    def login(email, password)
      user = User.find_by(:email => email)

      if user && user.authenticate(password)
        session[:id] = user.id
        redirect "/babies"
      else
        redirect to "/signup"
      end
    end

    def logout!
      session.clear
    end

  end

end
