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

  def hot_or_not
    @user = current_user
    # binding.pry
    all_products = Product.all
    all_products.to_a.delete_if { |product| Rating.where(product_id: product.id).size == 0}

    # each do |product|
    #   unless Rating.where(user_id: @user.id, product_id: product.id).size == 0
    #     all_products.delete(product)
    #   end
    # end
    @product = all_products.sample
    authorize @product
  end
end
