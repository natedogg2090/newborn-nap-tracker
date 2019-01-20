class NapsController < ApplicationController

  post "/naps" do
    if logged_in?
      user = User.find_by(session[:id])
      baby = Baby.find_by(name: params[:baby_name].downcase)
      if baby == nil
        redirect to "/babies"
      else
        nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
        nap.baby_id = baby.id
        nap.save

        flash[:message] = "Nap logged. Be sure to get some rest yourself."
        
        redirect to "/naps/#{nap.id}"
      end
    else
      redirect to "/login"
    end
  end

  get "/naps/:id" do
    @nap = Nap.find_by_id(params[:id])
    @baby = Baby.find_by_id(@nap.baby_id)

    @nap_start = @nap.start_time.to_s.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
    @nap_end = @nap.end_time.to_s.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
    erb :'naps/show'
  end

  get "/naps/:id/edit" do
    if !logged_in?    
      redirect to "/login"
    else
      @nap = Nap.find_by_id(params[:id])
      @baby = Baby.find_by_id(@nap.baby_id)

      if @baby.user_id == current_user.id
        @nap_start = @nap.start_time.to_s.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
        @nap_end = @nap.end_time.to_s.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
        erb :'naps/edit'
      else
        redirect to "/babies"
      end
    end
  end

end