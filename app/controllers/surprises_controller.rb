class SurprisesController < ApplicationController
  before_action :authenticate_user!, only: [:surprise_details, :show, :index]
  before_action :set_surprise, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @product = Product.find(@surprise[:product_id])
    @surprise.update_attributes(status: "confirmé")
    # authorize @surprise
  end

  def edit
  end

  def create
    @surprise = Surprise.new(surprise_params2)
    @surprise.product_id = session[:product_id]
    @surprise.user_id = current_user.id
    @surprise.amount = @surprise.product.price
    @surprise.save!
    redirect_to surprise_path(@surprise)
  end


  def surprise_details
    @user = current_user
    @surprise = Surprise.new(product_id: session[:product_id])
    authorize @surprise
  end

  def initiate_prod_cookie
    #On récupère les 3 critères dans les params
    @budget = params[:budget]
    @gender = params[:gender]
    @surprise_category = params[:surprise_category]
    #On demande un produit aléatoire sur la base des 3 critères
    @product_id = Product.random(@budget, @gender, @surprise_category)

    # On crée une instance de surprise et on la met dans le cookie (miam !)
    session[:product_id] = nil
    session[:product_id] = @product_id
    redirect_to surprise_details_path
  end
  private

  def set_surprise
    @surprise = Surprise.find(params[:id])
  end

  def surprise_params
     params.permit(:budget, :gender, :surprise_type)
  end

  def surprise_params2
     params.require(:surprise).permit(:del_first_name, :del_last_name, :del_address, :bill_first_name, :bill_last_name, :bill_address)
  end

  def order_params
    params.require(:order).permit(:status)
  end


end

