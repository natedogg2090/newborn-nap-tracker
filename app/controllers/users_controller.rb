class UsersController < ApplicationController

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

  get "/logut" do
    if session[:user_id] != nil
      session.clear
      redirect to "/"
    else
      redirect to "/"
    end
  end

end