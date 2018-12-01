def app
  ApplicationController
end

describe ApplicationController do


  describe "Homepage" do
    before(:each) do
      get '/'
    end

    it "loads the homepage" do
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to the Newborn Nap Tracker!")
    end
    
  end

  describe "signup" do
    before do
      visit '/'
    end

    it "links to signup page" do
      expect(page).to have_selector("a[href='/signup']")
    end

  end

  describe "login" do
    before do
      visit '/'
    end

    it "links to login page" do
      expect(page).to have_selector("a[href='/login']")
    end

  end

end
