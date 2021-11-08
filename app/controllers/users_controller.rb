class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @histories = @user.histories.paginate(page: params[:page], per_page: 10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id    #autologin after registration
      flash[:notice] = "Welcome to the Parking spot application #{@user.username}"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
