class SessionsController < ApplicationController
   def new
    # No need for anything in here, we are just going to render our
    # new.html.erb AKA the login page
  end

  def create
    user = User.find_by(name: params[:login][:name])

    if user && user.authenticate(params[:login][:password]) 
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = "Incorrect name or password, try again."
      render :new
    end
  end

  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end
