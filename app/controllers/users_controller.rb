class UsersController < ApplicationController

  get "/signup" do
    erb :'users/signup'
  end

  post "/signup" do
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    
    if user.save
      redirect to '/login'
    else
      redirect to "/signup"
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