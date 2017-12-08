class SurprisesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
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

