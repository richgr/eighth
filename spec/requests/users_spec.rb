require 'spec_helper'

describe "Users" do

  describe "signup" do
  
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          # Searching for a CSS id?  Try div#error
          response.should have_selector('div#error_explanation') 
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "success test"
          fill_in "Email",        :with => "succes@success.com"
          fill_in "Password",     :with => "football"
          fill_in "Confirmation", :with => "football"
          click_button
          # Searching for a CSS class or 2?  Use div.flash.success
          response.should have_selector('div.flash.success', 
                                        :content => "Welcome") 
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

  end
  
  
  
  # Graham had fun making this one up!!!!
  #
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
