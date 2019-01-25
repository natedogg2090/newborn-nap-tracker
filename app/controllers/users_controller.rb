class UsersController < ApplicationController

  get "/signup" do
    erb :'users/signup'
  end

  post "/users" do
    if existing_user
      redirect to '/login'
    else
      user = User.new(name: params[:name], email: params[:email], password: params[:password])
    
      if user.save
        redirect to '/login'
      else
        erb :'users/signup'
      end
    end

  end

end