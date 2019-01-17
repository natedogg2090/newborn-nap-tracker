class UsersController < ApplicationController

  get "/signup" do
    if session[:email] == nil
      erb :'users/signup'
    else
      redirect to '/babies'
    end
  end

  post "/signup" do
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    
    if user.save
      if user.authenticate(params[:password])
        session[:email] = @user.id
      end
      redirect to '/babies'
    else
      redirect to '/signup'
    end

  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    if login(params[:email], params[:password])
      redirect to "/babies"
    else
      redirect to "/signup"
    end
    
  end

  get "/logout" do
    logout!
    redirect to "/"
  end

end