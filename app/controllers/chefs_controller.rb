class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_user, only: :destroy

  def index
    @chefs=Chef.paginate(page: params[:page], per_page: 3)
  end

  def register
    if logged_in?
      flash[:danger]='You are already registered and logged in..'

      redirect_to chefs_path
    else
      @chef=Chef.new
    end
  end

  def create
      @chef=Chef.new chef_params
    if @chef.save
      flash[:success]='Account successfully created..'
      session[:chef_id]=@chef.id

      redirect_to recipes_path
    else
      render 'register'
    end
  end

  def edit
  end

  def update
    if @chef.update chef_params
      flash[:success]='Profile successfully updated'

      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end

  def show
    @recipes=@chef.recipes.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    if current_user.admin?
      @chef.destroy!
      flash[:success]="Chef successfully deleted.."

      redirect_to chefs_path
    else
      flash[:danger]="You must be an Admin to delete users!"

      redirect_to chefs_path
    end
  end


  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end

    def require_same_user
      if !logged_in?
        flash[:danger]='You must be logged in to perform this action'

        redirect_to login_path

      elsif current_user != @chef and !current_user.admin?
        flash[:danger]='You can only edit your own profile profile'

        redirect_to home_path
      end
    end

    def set_chef
      @chef=Chef.find params[:id]
    end

end
