require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Home page at root_path" do
    visit root_path
    response.should have_selector('title', :content => "Home")
  end
  
  # Beware!  The 'click_link' command takes you to the new page.
  #          All future test will be on the new page, not the starting page.
  it "should have the right links on the layout" do
    visit root_path
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have a Contact page at contact_path" do
    visit contact_path
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have an About page at about_path" do
    visit about_path
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a Help page at help_path" do
    visit help_path
    response.should have_selector('title', :content => "Help")
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have a signup page at signup_path" do
    visit signup_path
    response.should have_selector('title', :content => "Sign up")
  end


end