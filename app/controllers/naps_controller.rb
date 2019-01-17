class NapsController < ApplicationController

  post "/naps" do
    if logged_in?
      user = User.find_by(session[:id])
      baby = Baby.find_by(name: params[:baby_name].downcase)
      nap = Nap.new(start_time: params[:start_time], end_time: params[:end_time], notes: params[:notes])
      nap.baby_id = baby.id
      nap.save

      flash[:message] = "Nap logged. Be sure to get some rest yourself."
      
      redirect to "naps/#{nap.id}"
    end
  end

  get "/naps/:id" do
    @nap = Nap.find_by_id(params[:id])
    @baby = Baby.find_by(id: @nap.baby_id)
    erb :'naps/show'
  end

  get "/naps/:id/edit" do
    # binding.pry
    @naps = Nap.find_by_id(params[:id])

    nap_start_string = @naps.start_time.to_s
    @nap_start = nap_start_string.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
    nap_end_string = @naps.end_time.to_s
    @nap_end = nap_end_string.slice(/(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/)
    erb :'naps/edit'
  end

end