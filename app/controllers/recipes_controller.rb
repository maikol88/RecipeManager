class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    #binding.pry to check parameters
    #I can type params on the terminal when on pry to see what parameters are being passed
    # We can see that we are looking for the id params
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #for now  we will hardcode a chef
    @recipe.chef = Chef.find(1)

    if @recipe.save
      flash[:success] = 'Your recipe was created succesfully!'
      redirect_to recipes_path
    else
      render :new
    end
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description)
    end

  def edit

  end

  def update

  end

end
