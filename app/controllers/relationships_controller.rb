class RelationshipsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    @followed = User.find_by_id(params[:relationship][:followed_id])
    current_user.follow!(@followed)
    respond_to do |format|
      format.html { redirect_to @followed }
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to(@user) }
      format.js
    end
  end
    
end
