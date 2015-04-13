class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :destroy, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @recipes=Recipe.paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  def new
    @recipe=Recipe.new
  end

  def create
    # binding.pry

    # Rails forces the use of 'Strong Parameters' where we have to white-list what we pass through POST method
    # This is done through a private function that permits only what we need from params object
    @recipe=Recipe.new recipe_params
    @recipe.chef=current_user

    if @recipe.save
      flash[:success] = 'Recipe successfully added to your recipes portfolio..'

      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @recipe.update recipe_params
      flash[:success]='Recipe successfully updated..'

      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    #binding.pry
    like=Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "You #{params[:like]=='true' ? 'liked' : 'disliked'} the recipe.."
    else
      flash[:danger] = "You can only vote once for each item.."
    end

    redirect_to :back
  end

  def destroy
    if @recipe.destroy
      flash[:success]='Recipe deleted..'

      redirect_to recipes_path
    else
      render :edit
    end
  end


  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids:[], ingredient_ids:[])
    end

    def set_recipe
      @recipe=Recipe.find params[:id]
    end

    def require_same_user
      if current_user != @recipe.chef and !current_user.admin?
        flash[:danger]="You can only edit your own recipes"

        redirect_to recipes_path
      end
    end

  def require_user_like
    if !logged_in?
      flash[:danger]='You must be logged in to perform this action'

      redirect_to :back
    elsif current_user.admin?
      flash[:danger]="An admin is not allowed to vote!"

      redirect_to :back
    end
  end

end
