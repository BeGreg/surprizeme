class SurprisesController < ApplicationController
    before_action :set_surprise, only: [:show, :edit, :update, :destroy]
  def index
  end

  def new
  end

  def show
    @product = Product.find(@surprise[:product_id])
    authorize @surprise
  end

  def edit
  end

  private

  def set_surprise
    @surprise = Surprise.find(params[:id])
  end

end
