class IngredientsController < ApplicationController

  def index

  end

  def show
    @ingredient=Ingredient.find params[:id]
  end

  def new
    @ingredient=Ingredient.new
  end

  def create
    @ingredient=Ingredient.new ingredient_params
    if @ingredient.save
      flash[:success]='Ingredient successfully created..'

      redirect_to ingredients_path
    else
      render :new
    end
  end

  def update

  end

  def destroy

  end


  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

end