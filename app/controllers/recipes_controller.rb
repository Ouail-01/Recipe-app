class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index public_recipes]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @foods = Food.joins(:recipe_foods).where(recipe_foods: { recipe_id: @recipe.id })
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def public_recipes
    @is_public = Recipe.where(is_public: true).includes(:user, :recipe_foods).order('created_at DESC')
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
    else
      redirect_to recipes_path, alert: 'There was an error deleting the Recipe.'
    end
  end

  def toogle
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.is_public = !@recipe.is_public
    if @recipe.save
      redirect_to(request.referrer || root_path)
    else
      flash[:error] = 'Error updating recipe'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :is_public)
  end
end
