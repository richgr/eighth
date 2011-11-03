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
        
        30.times do
          Factory(:user, :email => Factory.next(:email) )
        end
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
        User.paginate(:page => 1).each do |user|
          response.should have_selector('li', :content => user.name)
        end
      end
      
      it "should paginate users" do
        get :index
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', :content => "Previous")
        response.should have_selector('a',  :href => '/users?page=2',
                                            :content => '2')
        response.should have_selector('a',  :href => '/users?page=2',
                                            :content => 'Next')
      end
      
      it "should have delete links for admins" do
        @user.toggle!(:admin)
        other_user = User.all.second
        get :index
        response.should have_selector('a',  :href => user_path(other_user),
                                            :content => "delete" )
      end
      
      it "should NOT have delete links for non-admins" do
        other_user = User.all.second
        get :index
        response.should_not have_selector('a', :href => user_path(other_user),
                                               :content => "delete" )
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
      # @user = Factory(:user)
      @user = test_sign_in(Factory(:user))
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
      response.should have_selector('div>a',  :href => user_path(@user))
      # , :content => user_path(@user) )    # new template
    end
    
    it "should show the user's microposts'" do
      mp1 = Factory(:micropost, :user => @user, :content => "Football")
      mp2 = Factory(:micropost, :user => @user, :content => "Soccer")
      get :show, :id => @user
      response.should have_selector("span.content", :content => mp1.content)
      response.should have_selector("span.content", :content => mp2.content)
    end

    describe "when signed in as another user" do
      
      it "should be successful" do
        test_sign_in(Factory(:user, :email => Factory.next(:email)))
        get :show, :id => @user
        response.should be_success
      end
      
    end
    
    
  end  # end get show
  
  
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
  
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "as a non-signed-in user (failure)" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end
    
    describe "as a non-admin user (failure)" do
      it "should protect the action" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end
    
    describe "as an admin user" do
      
      before(:each) do
        @admin = Factory(:user, :email => "admin@example.com",
                        :admin => true)
        test_sign_in(@admin)
      end
      
      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
      
      it "should not be able to destroy itself" do
        lambda do 
          delete :destroy, :id => @admin
        end.should_not change(User, :count)
      end   
      
    end
    
  end
  
  describe "micropost associations" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      # @user = User.create(@attr)
      @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
    end
    
    describe "status feed" do
      
      it "should have a feed" do
        @user.should respond_to(:feed)
      end
      
      it "should include the user's microposts" do
        @user.feed.include?(@mp1).should be_true
        @user.feed.include?(@mp2).should be_true
      end
      
      it "should not include a different user's microposts" do
        mp3 = Factory(:micropost,
                      :user => Factory(:user, :email => Factory.next(:email)))
      end
      
    end
    
  end

end
