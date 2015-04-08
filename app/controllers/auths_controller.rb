class AuthsController < ApplicationController

  def login
  end

  def create
    chef=Chef.find_by_email params[:email]
    if chef && chef.authenticate(params[:password])
      flash[:success]='You logged in successfully..'
      session[:chef_id]=chef.id

      redirect_to recipes_path
      #binding.pry
    else
      flash.now[:danger] = "Your email or password don't match.."
      render 'login'
    end
  end

  def logout
    session[:chef_id]=nil
    flash[:success]='You successfully logged out..'

    redirect_to home_path
  end

end
