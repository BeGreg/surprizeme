class SurprisesController < ApplicationController

    before_action :set_surprise, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def show
    @product = Product.find(@surprise[:product_id])
  end

  def edit
  end


  private

  def set_surprise
    @surprise = Surprise.find(params[:id])
  end


  
  def surprise_details
    @surprise = Surprise.new
    authorize @surprise, :surprise_details?
  end


  def initiate_prod_cookie
    puts "ca commence!"

    session[:surprise] = nil
    surprise = Surprise.new(surprise_params)
    session[:surprise] = surprise
    redirect_to surprise_details_path
  end

  private

  def surprise_params
     params.permit(:budget, :gender, :surprise_type)
  end



end

