class NapsController < ApplicationController

  post "/naps" do
    if !logged_in?
      redirect to "/login"
    else
      if baby = current_user.babies.find_by_id(params[:id])
        nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
        nap.baby_id = baby.id
        nap.save

        flash[:message] = "Nap logged. Be sure to get some rest yourself."
        
        redirect to "/naps/#{nap.id}"
      else
        redirect to "/babies"
      end
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

  patch "/naps/:id" do
    if !logged_in?
      redirect to "/login"
    else
      if baby = Baby.find_by_id(params[:baby_id]).user_id == current_user.id
        nap = Nap.find_by_id(params[:id])
        nap.update(start_time: params[:start_time].to_datetime, end_time: params[:end_time].to_datetime, notes: params[:notes])
        
        flash[:message] = "This nap has been updated. Are you getting some rest?"

        redirect to "/naps/#{nap.id}"
      else
        redirect to "/babies"
      end
    end
  end

  delete "/naps/:id" do
    if !logged_in?
      redirect to "/login"
    else
      if baby = Baby.find_by_id(params[:baby_id]).user_id == current_user.id
        nap = Nap.find_by_id(params[:id])
        nap.delete

        redirect to "/babies/#{nap.baby_id}"
      else
        redirect to "/babies"
      end
    end
  end

end