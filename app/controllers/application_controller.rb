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

  patch "/naps/:id" do
    if logged_in?
      nap = Nap.find_by_id(params[:id])
      nap.update(start_time: params[:start_time].to_datetime, end_time: params[:end_time].to_datetime, notes: params[:notes])
      
      flash[:message] = "This nap has been updated. Are you getting some rest?"

      redirect to "/naps/#{nap.id}"
    else
      redirect to "/login"
    end
  end

  patch "/babies/:id" do
    if logged_in?
      baby = Baby.find_by_id(params[:id])
      baby.update(name: params[:name], birthday: params[:birthday].to_date)
      
      flash[:message] = "Your baby has been updated."
      
      redirect to "/babies/#{baby.id}"
    else
      redirect to "/login"
    end
  end

  delete "/naps/:id/delete" do
    if logged_in?
      nap = Nap.find_by_id(params[:id])
      nap.delete

      redirect to "/babies/#{nap.baby_id}"
    else
      redirect to "/login"
    end
  end

  delete "/babies/:id/delete" do
    if logged_in?
      baby = Baby.find_by_id(params[:id])
      baby.delete

      redirect to "/babies"
    else
      redirect to "/login"
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end

    def login(email, password)
      user = User.find_by(:email => email)

      if user && user.authenticate(password)
        session[:email] = user.email
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
