class SurprisesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def initiate_prod_surprise
    puts "ca commence!"
    product_id = params[:id]
    quantity = params[:quantity]
    if buyer_signed_in?
      order = order_en_cours
      clean_cookies(order)
      if item_in_basket?(order, product_id)
        iterate_item(order, product_id, quantity)
      else
        Basket.create(order_id: order.id, product_id: product_id, quantity: 1)
      end
    elsif session[:basket].nil?
      session[:basket] = {}
      session[:basket][product_id.to_sym] = quantity
    else
      basket = session[:basket]
      if basket[product_id].nil?
        basket[product_id] = quantity
      else
        basket[product_id] += quantity
      end
    session[:basket] = basket
    end
    session[:basket]
  end
  end


end
