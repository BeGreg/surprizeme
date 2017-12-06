class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end
# test
  def styleguide
  end

end
