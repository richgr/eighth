class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy


  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page], 
                                            :per_page => 8)    
    @title = "Show " + @user.name
  end


  def new
    @user = User.new
    @title = "Sign up"
  end

  # CREATE a new user and redirect to the user's page
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
    else
      flash.now[:error] = "Sorry, please try again."
      @title = "Sign up"
      render 'new'
    end
  end


  def edit
    @title = "Edit user: " + @user.name
  end


  def update
    if @user.update_attributes(params[:user])
      @title = "Show user: " + @user.name
      # render 'show'
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user: " + @user.name
      render 'edit'
    end
  end

 
  # DELETE /users/1
  #  Think of this as "a 'delete' request was submitted, so do it,
  #                                  then redirect somewhere above
  #                                          with a status message"
  def destroy
    if User.find(params[:id]).destroy
      redirect_to users_path, :flash => 
                        { :success => 'User was successfully deleted. ' }
    else
      redirect_to users_path, :flash => 
                        { :error => 'FAIL: User was NOT deleted.' }
    end
  end  
  
  private
  
    # deny_access moved to sessions_helper
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end 
    
    def admin_user
      user = User.find(params[:id])
      redirect_to(root_path, :flash => {:error => "Could not delete user"}) \
        if (!current_user.admin? || current_user?(user))
    end
    
      
end
