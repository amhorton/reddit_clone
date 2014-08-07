class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    sign_in_user(@user) if @user

    if signed_in?
      flash[:notice] = "Signed in successfully!"
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid username or password."]
      render :new
    end
  end

  def destroy
    sign_out
  end
end