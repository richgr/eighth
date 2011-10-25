require 'spec_helper'

describe "Users" do

#  describe "GET /users" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get users_path
#      response.status.should be(200)
#    end
#  end


  # Retrieve the first valid user from the database
  # BE SURE your test database has at least one user! ####
  before(:each) do
    @user = User.first
  end

  it "should visit a valid users_path" do
    visit users_path
    response.should have_selector('title', :content => "Users")
  end
 
  it "should visit a valid user_path(@user)" do
    visit user_path(@user)
    response.should have_selector('title', :content => "Show")
  end
  
  it "should visit a valid new_user_path" do
    visit new_user_path
    response.should have_selector('title', :content => "Sign up")
  end
  
  it "should visit a valid edit_user_path(@user)" do
    visit edit_user_path(@user)
    response.should have_selector('title', :content => "Edit")
  end

end
