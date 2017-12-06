class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: :search
  def new
  end

  def show
  end

  def edit
  end

  def index
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
