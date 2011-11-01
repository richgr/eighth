class MicropostsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])    
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to(user_path(current_user)) 
    else
      flash.now[:error] = "Sorry, please try again."
      @feed_items = []
      # Micropost form is now shared between pages
      # How do I know what page the user was on?
      render('pages/home') 
    end
  end
  
  def destroy
    @micropost.destroy ?  flash[:success] = 'Micropost deleted.' : \
                          flash[:error]   = 'Micropost NOT deleted.'
    redirect_back_or root_path
  end
  
  private
  
    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end 

end
