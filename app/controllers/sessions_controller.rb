class SessionsController < ApplicationController

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