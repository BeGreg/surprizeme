class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: :search
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


  def search
    @budget = params[:budget]
    @gender = params[:gender]
    @surprise_category = params[:surprise_category]
    @productList = []
    Product.all.each do |product|
      if ((product.price + product.delivery_price) < @budget)  && product.gender == @gender && product.surprise_category ==  @surprise_category
        @productList << product
      end
    p @productList
    end
  end






end
