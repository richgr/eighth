class MicropostsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])    
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to(user_path(current_user)) 
    else
      flash.now[:error] = "Sorry, please try again."
      # Micropost form is now shared between pages
      # How do I know what page the user was on?
      render('pages/home') 
    end
  end
  
  def destroy
    
  end

end
