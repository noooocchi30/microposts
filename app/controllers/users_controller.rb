class UsersController < ApplicationController
before_action :current_user_check,only: [:edit,:update]

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
   @user = User.find(params[:id])
  end
  
   def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
   end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  #課題2 追記
  def followings
    @user = User.find(params[:id])
    @users =  @user.following_users
    
  end

  def followers
    @user = User.find(params[:id])
    @users =  @user.follower_users
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:region)
  end
  
  private
  
  def current_user_check
    @user = User.find(params[:id])

    if current_user != @user
      redirect_to root_path , notice: 'ユーザーが異なります'
    end
  end
end