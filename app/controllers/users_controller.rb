class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def login
    @user = User.find_by_username(params[:username])

    if @user && !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect_to '/'
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
