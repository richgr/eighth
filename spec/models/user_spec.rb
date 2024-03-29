# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
              :name => "Example User", 
              :email => "user@example.com", 
              :password => "foobar" 
            }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "b" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should reject names that are too short" do
    short_name = "b" * 4
    short_name_user = User.new(@attr.merge(:name => short_name))
    short_name_user.should_not be_valid
  end

  it "should reject emails that are too long" do
    long_email = "b" * 51
    long_email_user = User.new(@attr.merge(:email => long_email))
    long_email_user.should_not be_valid
  end

  it "should reject emails that are too short" do
    short_email = "b" * 4
    short_email_user = User.new(@attr.merge(:email => short_email))
    short_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |addr|
      valid_email_user = User.new(@attr.merge(:email => addr))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    bad_addresses = %w[user@foo,com user_at_foo.org first.last@foo.]
    bad_addresses.each do |bad_addr|
      invalid_email_user = User.new(@attr.merge(:email => bad_addr))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with a given email address into the database.
    first_user = User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end


  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

  end


  describe "password encryption" do
 
    before(:each) do
      @user = User.create!(@attr)
    end
  
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
    

  
    it "should have a salt" do
      @user.should respond_to(:salt)
    end


    describe "has_password? method" do

      it "should exist" do
        @user.should respond_to(:has_password?)
      end

      it "should return true if the passwords match" do
        @user.has_password?(@attr[:password])
      end

      it "should return false if the passwords don't match" do
        @user.has_password?("invalid")
      end
    end

    describe "authenticate method" do

      it "should exist" do
        User.should respond_to(:authenticate)
      end

      it "should return nil on email/password mismatch" do
        User.authenticate(@attr[:email], "wrong_password").should be_nil
      end

      it "should return nil on email address with no user" do
        User.authenticate("bar@foo.com", @attr[:password]).should be_nil
      end

      it "should return the user on email/password match" do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
 
    end

  end
  
  describe "admin attribute" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
    
  end
  
  
  
  describe "relationships" do
    
    before(:each) do
      @user = User.create!(@attr)
      @followed = Factory(:user)
    end
    
    it "should have a relationships method" do
      @user.should respond_to(:relationships) 
    end
    
    it "should have a following method" do
      @user.should respond_to(:following) 
    end
    
    it "should have a following? method" do
      @user.should respond_to(:following?) 
    end
    
    it "should have a follow! method" do
      @user.should respond_to(:follow!) 
    end
    
    it "should follow another user" do
      @user.follow!(@followed)
      @user.should be_following(@followed)
    end
    
    it "should include the followed user in the following array" do
      @user.follow!(@followed)
      @user.following.should include(@followed)
    end
    
    it "should have an unfollow! method" do
      @followed.should respond_to(:unfollow!) 
    end
    
    it "should unfollow a user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      @user.should_not be_following(@followed)
    end
    
    it "should have a reverse_relationships method" do
      @user.should respond_to(:reverse_relationships) 
    end
    
    it "should have a followers method" do
      @user.should respond_to(:followers) 
    end
    
    it "should include the follower in the followers array" do
      @user.follow!(@followed)
      @followed.followers.should include(@user)
    end

  end
  
  describe "delete relationships dependent on user" do
    
    before(:each) do
      @user = User.create!(@attr)
      @followed = Factory(:user)
      @follower = Factory(:user, :email => Factory.next(:email))
    end

    it "should destroy the user's followed relationships (destroy)" do
      @user.follow!(@followed)
      lambda do
        @user.destroy
      end.should change(Relationship, :count).by(-1)
    end
      
    it "should destroy the user's follower relationships (destroy)" do
      @follower.follow!(@user)
      lambda do
        @user.destroy
      end.should change(Relationship, :count).by(-1)
    end
      
  end
  
  describe "status feed" do
  
    before(:each) do
      @attr2 = { 
            :name => "Example User", 
            :email => "user@example.com", 
            :password => "foobar" 
          }
      @user = User.create!(@attr2)
      @mp1 = @user.microposts.create!(:content => "foo")
      @mp2 = @user.microposts.create!(:content => "bar")
    end

    it "should have a feed" do
    # pending
      @user.should respond_to(:feed)
    end
    
    it "should include the user's microposts" do
    # pending
      @user.feed.should include(@mp1)
      @user.feed.should include(@mp2)
    end
    
    it "should not include a different user's microposts" do
    # pending
      mp3 = Factory(:micropost, 
                    :user => Factory(:user, :email => Factory.next(:email)))
      @user.feed.should_not include(mp3)
    end
    
    it "should include the microposts of followed users" do
    # pending
      followed = Factory(:user, :email => Factory.next(:email))
      mp3 = followed.microposts.create!(:content => "figgle")
      @user.follow!(followed)
      # mp3 = Factory(:micropost, :user => followed)
      @user.feed.should include(mp3)
    end
    
  end
    
end
