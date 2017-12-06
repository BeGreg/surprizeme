class ProductsController < ApplicationController
  def new
  end

  def show
  end

  def edit
  end

  def index
    @products = Product.all
  end

  def hot_or_not
    @user = current_user
    unrated_products = Rating.where.not(user_id: @user.id).products
    @product = unrated_products.sample
  end
end
