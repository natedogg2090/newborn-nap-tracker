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
    if session[:user_id] == nil
      erb :'users/signup'
    else
      redirect to '/index'
    end
  end

  post "/signup" do
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    
    if user.save
      if user.authenticate(params[:password])
        session[:user_id] = @user.id
      end
      redirect to '/index'
    else
      redirect to '/signup'
    end

  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/index'
    else
      redirect to '/signup'
    end
    
  end

  get "/index" do
    if logged_in?
      @user = User.find_by(session[:user_id])
      erb :'babies/index'
    else
      redirect to '/'
    end
  end

  get "/new" do
    erb :'babies/new'
  end

  post "/babies" do
    if logged_in?
      user = User.find_by(session[:user_id])
      baby = Baby.new(name: params[:name], birthday: params[:birthday])
      baby.user_id = user.id
      baby.save

      redirect to "/babies/#{baby.id}"
    else
      redirect to "/signup"
    end
  end

  get "/babies/:id" do
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/index'
  end

  get "/babies/:id/new" do
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/new'
  end

  get "/babies/:id/edit" do
    @baby = Baby.find_by_id(params[:id])
    birthday_string = @baby.birthday.to_s
    @birthday = birthday_string.slice(/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/)
    erb :'babies/edit'
  end

  post "/naps/:id" do
    user = User.find_by(session[:id])
    nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
    nap.save
    
    redirect to "naps/show"
  end

  get "/naps/:id" do
    @naps = Nap.find_by_id(params[:id])
    erb :'naps/show'
  end

  patch "/babies/:id" do
    baby = Baby.find_by_id(params[:id])
    baby.update(name: params[:name], birthday: params[:birthday].to_date)
    redirect to "babies/#{baby.id}"
    #flash a message displaying to the user they have successfully updated the baby
  end

  patch "naps/:id" do

  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end

end
