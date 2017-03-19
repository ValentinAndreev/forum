class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def dashboard
    @search = User.search(params[:q])
    @searched_users = @search.result
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_path, notice: 'Succesfully registered'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile was changed'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User was deleted'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
