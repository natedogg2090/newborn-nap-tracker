require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_secure"
  end

  get "/" do
    erb :welcome
  end

  get "/signup" do
    erb :'users/signup'
  end

  post "/signup" do
    
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user.save

    redirect to '/babies/index'
  end

end
