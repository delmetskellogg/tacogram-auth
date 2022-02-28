class SessionsController < ApplicationController
  def new
  end
  
  def create
    # authenticate the user
    # @user = User.where({ email: params["email"] })[0]
    @user = User.find_by({ email: params["email"] })
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        flash[:notice] = "Welcome, #{@user.first_name}."
        redirect_to "/posts"
      else
        flash[:notice] = "Nope"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Nope"
      redirect_to "/sessions/new"
    end
  end
end
