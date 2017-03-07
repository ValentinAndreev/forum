class UsersessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: 'Succesfully logined'
    else
      flash.now[:alert] = "Can't login"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logout'
  end
end