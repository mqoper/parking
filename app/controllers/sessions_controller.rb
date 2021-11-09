class SessionsController < ApplicationController
  def new
  end


  def create
    @user = User.find_or_create_by(full_name: auth_hash.info.name, member_id: auth_hash.info.user_id)

    session[:user_id] = @user.id
    redirect_to '/'
  end

  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     session[:user_id] = user.id
  #     flash[:notice] = "Logged in successfully"
  #     redirect_to user
  #   else
  #     flash.now[:alert] = "There was something wrong with your login details"
  #     render 'new'
  #   end
  # end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end



end