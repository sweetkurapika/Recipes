class StylesController < ApplicationController
  before_action :require_user, except: [:show, :index]

  def show
    @style=Style.find params[:id]
    @recipes=@style.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @style=Style.new
  end

  def create
    @style=Style.new style_params
    @style.name.capitalize!
    if @style.save
      flash[:success]='Style successfully created..'

      redirect_to styles_path
    else

      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end


  private
    def style_params
      params.require(:style).permit(:name)
    end

end