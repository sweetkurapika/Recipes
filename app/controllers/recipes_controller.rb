class RecipesController < ApplicationController

  def index
    @recipes=Recipe.all
  end

  def show
    @recipe=Recipe.find params[:id]
  end

  def new
    @recipe=Recipe.new
  end

  def create
    #binding.pry

    # Rails forces the use of 'Strong Parameters' where we have to white-list what we pass through POST method
    # This is done through a private function that permits only what we need from params object
    @recipe=Recipe.new recipe_params
    @recipe.chef=Chef.find 1

    if @recipe.save
      flash[:success] = 'Recipe successfully added to your recipes portfolio..'

      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @recipe=Recipe.find params[:id]
  end

  def update
    @recipe=Recipe.find params[:id]

    if @recipe.update recipe_params
      flash[:success]='Recipe successfully updated..'

      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end



  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end

end
