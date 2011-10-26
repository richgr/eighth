class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], 
                             params[:session][:password])
    if user.nil?
      @title = "Sign in"
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    else
      # flash[:success] = "User signin successful"
      # Handle successful sign in here
    end
  end
  
  def destroy
    
  end

end
