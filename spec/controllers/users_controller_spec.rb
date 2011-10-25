require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
       
  end
  
end


#  describe "Get 'show'" do
#  
#    before(:each) do
#      @user = Factory(:user)
#    end
#    
#    it "should be successful" do
#      get :show, :id => @user
#      response.should be_success
#    end
#    
#    it "should find the right user" do
#      get :show, :id => @user
#      assigns(:user).should == @user  #assigns @user to :user
#    end
#    
#    it "should have the right title" do
#      get :show, :id => @user
#      response.should have_selector('title', :content => @user.name)
#    end
#    
#    it "should have the user's name" do
#      get :show, :id => @user
#      response.should have_selector('h1', :content => @user.name)
#    end
#    
##    it "should have a profile image" do
##      get :show, :id => @user
##      response.should have_selector('h1>img', :class => "gravatar")
##    end
#    
#    it "should have the right URL" do
#      get :show, :id => @user
#      response.should have_selector('div>a',  :content => user_path(@user),
#                                              :href => user_path(@user))
#    end
#    
#  end
#
#
  
  
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  
#  
#  
#  # This should return the minimal set of attributes required to create a valid
#  # User. As you add validations to User, be sure to
#  # update the return value of this method accordingly.
#  def valid_attributes
#    {}
#  end
#
#  describe "GET index" do
#    it "assigns all users as @users" do
#      user = User.create! valid_attributes
#      get :index
#      assigns(:users).should eq([user])
#    end
#  end
#
#  describe "GET show" do
#    it "assigns the requested user as @user" do
#      user = User.create! valid_attributes
#      get :show, :id => user.id
#      assigns(:user).should eq(user)
#    end
#  end
#
#  describe "GET new" do
#    it "assigns a new user as @user" do
#      get :new
#      assigns(:user).should be_a_new(User)
#    end
#  end
#
#  describe "GET edit" do
#    it "assigns the requested user as @user" do
#      user = User.create! valid_attributes
#      get :edit, :id => user.id
#      assigns(:user).should eq(user)
#    end
#  end
#
#  describe "POST create" do
#    describe "with valid params" do
#      it "creates a new User" do
#        expect {
#          post :create, :user => valid_attributes
#        }.to change(User, :count).by(1)
#      end
#
#      it "assigns a newly created user as @user" do
#        post :create, :user => valid_attributes
#        assigns(:user).should be_a(User)
#        assigns(:user).should be_persisted
#      end
#
#      it "redirects to the created user" do
#        post :create, :user => valid_attributes
#        response.should redirect_to(User.last)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns a newly created but unsaved user as @user" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        User.any_instance.stub(:save).and_return(false)
#        post :create, :user => {}
#        assigns(:user).should be_a_new(User)
#      end
#
#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        User.any_instance.stub(:save).and_return(false)
#        post :create, :user => {}
#        response.should render_template("new")
#      end
#    end
#  end
#
#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested user" do
#        user = User.create! valid_attributes
#        # Assuming there are no other users in the database, this
#        # specifies that the User created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => user.id, :user => {'these' => 'params'}
#      end
#
#      it "assigns the requested user as @user" do
#        user = User.create! valid_attributes
#        put :update, :id => user.id, :user => valid_attributes
#        assigns(:user).should eq(user)
#      end
#
#      it "redirects to the user" do
#        user = User.create! valid_attributes
#        put :update, :id => user.id, :user => valid_attributes
#        response.should redirect_to(user)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns the user as @user" do
#        user = User.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        User.any_instance.stub(:save).and_return(false)
#        put :update, :id => user.id, :user => {}
#        assigns(:user).should eq(user)
#      end
#
#      it "re-renders the 'edit' template" do
#        user = User.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        User.any_instance.stub(:save).and_return(false)
#        put :update, :id => user.id, :user => {}
#        response.should render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested user" do
#      user = User.create! valid_attributes
#      expect {
#        delete :destroy, :id => user.id
#      }.to change(User, :count).by(-1)
#    end
#
#    it "redirects to the users list" do
#      user = User.create! valid_attributes
#      delete :destroy, :id => user.id
#      response.should redirect_to(users_url)
#    end
#  end
#
