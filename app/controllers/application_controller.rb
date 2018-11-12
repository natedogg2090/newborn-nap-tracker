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
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to 'index'
    else
      redirect to 'signup'
    end
    
  end

  get "/index" do
    erb :'babies/index'
  end

  get "/new" do
    erb :'babies/new'
  end

  post "/babies" do
    binding.pry
    if logged_in?
      user = User.find_by(session[:user_id])
      baby = Baby.new(name: params[:name], birthday: params[:birthday])
      baby.user_id = user.id
      baby.save

      redirect to "/babies/#{baby.id}/naps"
    else
      redirect to "/signup"
    end
  end

  get "/babies/:id/naps" do
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/index'
  end

  get "babies/:id/naps/new" do
    binding.pry
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/new'
  end

  post "/naps" do
    # binding.pry
    nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
    nap.save
    
    redirect to "naps/show"
  end

  get "/naps/show" do
    @nap = Nap.find_by
    erb :'naps/show'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end

end
