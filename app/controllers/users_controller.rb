class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update]

  def show
   @user = User.find(params[:id])
   
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit #追加

  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
 private
  
 def set_user
    @user = User.find(params[:id])
 end
 
  
end
