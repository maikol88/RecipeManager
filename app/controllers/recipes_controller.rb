class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  #we will require the user from the application controller since we are going to use it in more places
  before_action :require_user_like, only: [:like]
  before_action :require_same_user,only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    #@recipes = Recipe.all.sort_by { |likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)

  end

  def show
    #binding.pry to check parameters
    #I can type params on the terminal when on pry to see what parameters are being passed
    # We can see that we are looking for the id params
    #@recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #for now  we will hardcode a chef
    @recipe.chef = current_user

    if @recipe.save
      flash[:success] = 'Your recipe was created successfully!'
      redirect_to recipes_path
    else
      render :new
    end
  end
  #Edit uses updated immediately
  def edit

  end

  def update
    #@recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
     flash[:success] = "Your recipe was updated successfully"
     redirect_to recipe_path(@recipe)
     #path needs to receive the object
    else
      render :edit
    end
  end

  def like
    #@recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
    #redirect_to :back makes them stay where they were.
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe Deleted"
    redirect_to recipes_path
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, :preparation_time, :servings, style_ids: [], ingredient_ids: [])
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_same_user
      if current_user != @recipe.chef and !current_user.admin?
        flash[:danger] = "You can only edit your own recipes!"
        redirect_to recipes_path
      end
    end

    def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to :back
      end
    end

    def admin_user
      redirect_to recipes_path unless current_user.admin?
    end

end
