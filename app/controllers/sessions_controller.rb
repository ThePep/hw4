class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({email:params["email"]})
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        redirect_to "/places"
      else 
        flash[:notice] = "Incorrect password entered."
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Email does not exist."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

end
  