class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.create(foods_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to foods_path
    else
      render :new, status: 422
    end
  end

  private

  def foods_params
    params.require(:food).permit(:id, :name, :measurement_unit, :price, :quantity)
  end
end