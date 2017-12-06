class RatingsController < ApplicationController
  def new
  end

  def create
    @rating = current_user.ratings.build(review_params)
    @rating.save
    authorize @rating
    redirect_to hot_or_not_path

  end

  def edit

  end

  def hot_or_not
    @user = current_user
    # binding.pry
    all_products = Product.all
    all_products.to_a.delete_if { |product| Rating.where(product_id: product.id).size == 0}
    @product = all_products.sample
    authorize @product
  end

  private

  def review_params
     params.permit(:product_id, :rating)
  end

end
