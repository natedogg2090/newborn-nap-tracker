class BabiesController < ApplicationController

  get "/new" do
    erb :'babies/new'
  end

  get "/babies" do
    if logged_in?
      @user = User.find_by(:email => session[:email])
      erb :'babies/index'
    else
      redirect to "/login"
    end
  end

  post "/babies" do
    if logged_in?
      user = User.find_by(:email => session[:email])
      baby = Baby.new(name: params[:name], birthday: params[:birthday])
      baby.user_id = user.id
      baby.save

      flash[:message] = "Congratulations on the new addition to the family!"

      redirect to "/babies/#{baby.id}"
    else
      redirect to "/signup"
    end
  end

  get "/babies/:id" do
    @baby = Baby.find_by_id(params[:id])

    @naps = []
    Nap.all.each do |nap|
      if nap.baby_id == @baby.id
        @naps << nap
      end
    end

    erb :'naps/index'
  end

  get "/babies/:id/new" do
    @baby = Baby.find_by_id(params[:id])
    erb :'naps/new'
  end

  get "/babies/:id/edit" do
    if !logged_in?
      redirect to "/login"
    else
      if current_user.babies.find_by_id(params[:id]) != nil
        @baby = Baby.find_by_id(params[:id])
        birthday_string = @baby.birthday.to_s
        @birthday = birthday_string.slice(/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/)
        erb :'babies/edit'
      else
        redirect to "/babies"
      end
    end
  end

end