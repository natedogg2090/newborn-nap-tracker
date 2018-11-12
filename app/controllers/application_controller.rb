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

    redirect to '/index'
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(email: params[:email])

    redirect to '/index'
  end

  get "/index" do
    erb :'babies/index'
  end

  get "/new" do
    erb :'babies/new'
  end

  post "/babies" do
    @baby = Baby.new(name: params[:name], birthday: params[:birthday])
    @baby.save

    redirect to "/babies/#{@baby.id}"
  end

  get "/babies/:id" do
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/index'
  end

  get "/naps/new" do
    erb :'naps/new'
  end

  post "/naps" do
    @nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
    @nap.save
    
    redirect to "naps/show"
  end

end
