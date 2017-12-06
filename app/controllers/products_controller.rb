class ProductsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :hot_or_not
  def new
  end

  def show
  end

  def edit
  end

  def index
    @products = Product.all
  end
end
