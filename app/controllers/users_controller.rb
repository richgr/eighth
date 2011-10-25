class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @title = "All Users"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @title = "Show " + @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @title = "Sign up"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @title = "Edit " + @user.name
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
    else
      flash[:error] = "Sorry, please try again."
      @title = "Sign up"
      render 'new'
    end
  end

#  # POST /users
#  # POST /users.json
#  def create
#    #raise params[:user].inspect   # error page shows params
#    @user = User.new(params[:user])

##    respond_to do |format|
#      if @user.save
##        format.html { redirect_to @user, notice: 'User was successfully created.' }
##        format.json { render json: @user, status: :created, location: @user }
#      else
#        @title = "Sign up"
#        render 'new'
##        format.html { render action: "new" }
##        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
##    end
#  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
#  def destroy
#    @user = User.find(params[:id])
#    @user.destroy
#
#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :ok }
#    end
#  end
  
  # DELETE /users/1
  #  Think of this as "a 'delete' request was submitted, so do it,
  #                                  then redirect somewhere above
  #                                          with a status message"
  def destroy
    @user = User.find(params[:id])
    if request.delete? and @user.destroy
      flash[:notice] = 'User was successfully deleted. '
      redirect_to :action => 'index'
    else
      flash[:notice] = 'FAIL: User was NOT deleted.'
      redirect_to :action => 'index'
    end
  end  
  
  
  
end
