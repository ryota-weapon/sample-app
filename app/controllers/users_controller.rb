class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy] 
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] ="Please check your email to activate your account."
      redirect_to root_url
    else
      render "new", status: :unprocessable_entity
    end
    #   reset_session
    #   log_in @user      
    #   flash[:success] = "Welcome to the Sample App!"
    #   redirect_to @user
    #   # redirect_to user_url(@user)  same meaning as fucking above
    # else
    #   render "new", status: :unprocessable_entity
    # end
  end

  def edit
    @user = User.find(params[:id])  
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end
  


  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
        # beforeフィルタ


    # 正しいユーザーか？
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, status: :see_other) unless current_user?(@user)
    end

    # admin or not?
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
