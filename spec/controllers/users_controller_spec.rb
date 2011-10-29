require 'spec_helper'

describe UsersController do

  render_views
  
  describe "GET 'index'" do
    
    describe "for non-signed-in users - (deny)" do
      
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        Factory(:user, :email => "user@example.com")
        Factory(:user, :email => "another@example.com")
        Factory(:user, :email => "user@example.net")
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector('title', :content => "All users")
      end
      
      it "should have an <li> element for each user" do
        get :index
        User.all.each do |user|
          response.should have_selector('li', :content => user.name)
        end
      end
      
      
    end
    
    
  end
  
  

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

  describe "POST 'create'" do
  
    describe "failure" do
    
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should have the right title" do 
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign up")
      end 
               
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "should not create a user" do 
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    
    end 
    
    describe "success" do
    
      before(:each) do
        @attr = { :name => "New User", 
                  :email => "user@example.com",
                  :password => "football",
                  :password_confirmation => "football" }
      end
      
      it "should create a valid user" do
        lambda do
          post :create, :user => @attr  
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    
    end 
  
  end

  describe "Get 'show'" do
  
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user  #assigns @user to :user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end
    
    it "should have the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar")
    end
    
    it "should have the right URL" do
      get :show, :id => @user
      response.should have_selector('div>a',  :href => user_path(@user),
                                              :content => user_path(@user) )
    end
    
  end  # end factories
  
  
  describe "Get 'edit'" do
  
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector('title', :content => "Edit user")
    end
    
    it "should have a link to change the gravatar" do
      get :edit, :id => @user
      response.should have_selector('a',  
                                      :href => 'http://gravatar.com/emails',
                                      :content => 'Change')
    end
    
  end
  
  describe "PUT 'update" do 
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      @attr = { :name => "", :email => "", 
                :password => "",
                :password_confirmation => "" }

      it "should render the 'edit' page" do
        lambda do
          post :create, :user => @user
          controller.sign_in(@user)
          put :update, :id => @user, :user => @attr       #attr = attributes
          response.should render_template('edit')
        end
      end
      
      it "should have the right title" do
        lambda do
          post :create, :user => @user
          controller.sign_in(@user)
          put :update, :id => @user, :user => @attr       #attr = attributes
          response.should have_selector('title', :content => 'Edit user')
        end
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "New Name",
                  :email => "newuser@example.com",
                  :password => "barbaz",
                  :password_confirmation => "barbaz" }
      end
      
      it "should change the user's attributes" do
        lambda do
          post :create, :user => @user
          controller.sign_in(@user)
          put :update, :id => @user, :user => @attr     # @user from Factory
          user = assigns(:user)
          @user.reload
          @user.name.should == user.name
          @user.email.should == user.email
          @user.encrypted_password.should == user.encrypted_password
        end
      end
      
      it "should have a flash message" do
        lambda do
          post :create, :user => @user
          controller.sign_in(@user)
          put :update, :id => @user, :user => @attr     # @user from Factory
          flash[:success].should =~ /Profile updated/i
        end
      end
      
    end

  end
  
  describe "authenticationn of edit/update actions" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do
        
      it "should deny access to 'edit' if not signed in" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
        flash[:notice] =~ /sign in/i
      end
      
      it "should deny access to 'update' if not signed in" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path) 
      end
      
    end
    
    describe "for signed-in users" do
    
      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
      
      it "should require matching users for 'edit' - non-matching" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
        flash[:error] =~ /cannot/i
      end
      
      it "should require matching users for 'update' - non-matching" do
        get :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
        flash[:notice] =~ /cannot/i
      end
      
    end
        
  end
  

end

  
   
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
