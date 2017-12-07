class SurprisesController < ApplicationController

  def index
  end

  def new
  end

  def show
  end

  def edit
  end
  def surprise_details
    @surprise = Surprise.new
    authorize @surprise, :surprise_details?
  end
end
