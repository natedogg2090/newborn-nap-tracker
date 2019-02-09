class BabiesController < ApplicationController

  get "/new" do
    erb :'babies/new'
  end

  get "/babies" do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'babies/index'
    else
      redirect to "/login"
    end
  end

  post "/babies" do
    if logged_in?
      baby = Baby.new(name: params[:name], birthday: params[:birthday])
      baby.user_id = current_user.id
      baby.save

      flash[:message] = "Congratulations on the new addition to the family!"

      redirect to "/babies/#{baby.id}"
    else
      redirect to "/login"
    end
  end

  get "/babies/:id" do
    @baby = Baby.find_by_id(params[:id])
    @baby.naps

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
      @baby = current_user.babies.find_by_id(params[:id])

      if @baby != nil
        birthday_string = @baby.birthday.to_s
        @birthday = birthday_string.slice(/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/)
        erb :'babies/edit'
      else
        redirect to "/babies"
      end
    end
  end


  patch "/babies/:id" do
    if !logged_in?
      redirect to "/login"
    else
      if current_user.babies.find_by_id(params[:id]) != nil
        baby = Baby.find_by_id(params[:id])
        baby.update(name: params[:name], birthday: params[:birthday].to_date)
        
        flash[:message] = "Your baby has been updated."
        
        redirect to "/babies/#{baby.id}"
      else
        redirect to "/babies"
      end
    end
  end

  delete "/babies/:id" do
    if !logged_in?
      redirect to "/login"
    else
      if current_user.babies.find_by_id(params[:id]) != nil
        baby = Baby.find_by_id(params[:id])
        baby.delete

        redirect to "/babies"
      else
        redirect to "/babies"
      end
    end
  end

end