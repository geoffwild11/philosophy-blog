class SessionsController < ApplicationController
  def new
    #@user = User.find_by(email)
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log user in and redirect to user's home page
      log_in user
      redirect_to user
    else
      # Create error message
      flash.now[:danger] = 'Invalid email/password combination' # will fix up later
      render 'new'
    end
  end
  
  def destroy
  end
end
